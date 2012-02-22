/**
*   @desc: render rowselector in grid
*   @param: rsEditMode - show asteriks instead of arrow when editor opened
*   @param: rsWidth - set custom width for rowselector column, default 32
*   @param: rsAutoClose - set to false to prevent opened editor closing when clicking selected item
*   @after_init: 1
*   @type: public
*   @topic: 0
*/
dhtmlXGridObject.prototype.enableRowSelector = function(rsEditMode, rsWidth, rsAutoClose) {
	
	if (this._rsMode) return;
	
	this._rsMode = true;
	this._correction_x = (rsWidth||32);
	this._rsSel = {};
	this._rsEdit = null;
	this._rsEditMode = (rsEditMode===true);
	this._rsAutoClose = (typeof(rsAutoClose)!="undefined"?rsAutoClose===true:true);
	
	this._rsLastCliked = null;
	
	this._rsLastClickedArrow = true; // show arrow only for last cliked row in case of multiselect
	
	this.setSizes();
	
	this.attachEvent("onSetSizes", function(){
		this._rs_setSizes();
	});
	
	this.attachEvent("onRowInserted", function(row,ind,fil,type){
		this._rs_addRow(row,ind,fil,type);
	});
	
	this.attachEvent("onScroll", function(x,y){
		this._rs_onScroll(x,y);
	});
	
	this.attachEvent("onRowSelect", function(to){
		this._rs_doOnSelectHandler([to]);
	});
	
	this.attachEvent("onRowSelectRSOnly", function(to){
		this._rs_doOnSelectHandler([to]);
	});
	
	this.attachEvent("onSelectStateChanged", function(to,from){
		this._rs_doOnSelectHandler(String(to).split(","));
	});
	
	this.attachEvent("onSelectionCleared", function(){
		this._rs_clearSelection(true);
	});
	
	this.attachEvent("onResetView", function(){ // sorting,filtering
		this._rs_clearAll();
	});
	this.attachEvent("onAfterRowDeleted", function(id,pid){
		this._rs_deleteRow(id,pid);
	});
	
	this.attachEvent("onClearAll", function(){
		this._rs_clearAll();
	});
	
	this.attachEvent("onRowHide", function(id,state){
		this._rs_setRowHidden(id,state);
	});
	
	this.attachEvent("onBeforeSelect", function(id, ind){
		this._rsLastCliked = id;
		return true;
	});
	
	// editmode behavoour
	this.attachEvent("onEditCell", function(state,id,ind){
		if (!this.getRowById(id)) return;
		if (this.multiLine) this._rsObjBuf[id].firstChild.style.height = this.cells(id, ind).cell.parentNode.offsetHeight+"px";
		if (!this.cells(id,ind).isCheckbox() && this._rsEditMode) {
			if (state == 1) this._rs_switchMode("edit",id);
			if (state == 2) this._rs_switchMode("read",id);
		}
		return true;
	});
	this.attachEvent("onEditCancel", function(id,ind){
		if (this._rsEditMode) this._rs_switchMode("read");
		if (this.multiLine && this._rsObjBuf[id]) this._rsObjBuf[id].firstChild.style.height = this.cells(id, ind).cell.parentNode.offsetHeight+"px";
	});
	
	// smart rendering
	this.attachEvent("onAddFiller", function(pos,len,row,fil,rsflag){
		this._rs_addFiller(pos,len,row,fil,rsflag);
	});
	this.attachEvent("onUpdateFiller", function(fil){
		fil._rsf.firstChild.style.height = fil.firstChild.style.height;
	});
	this.attachEvent("onRemoveFiller", function(fil){
		this._rs_removeFiller(fil);
	});
	
	// extra lines
	this.attachEvent("onResetExtraLines", function(){
		this._rs_resetLineBox();
	});
	
	this.attachEvent("onExtraLine", function(mode){
		this._rs_initLineBox(mode===true);
	});
	
	this._rsCont = document.createElement("DIV");
	this._rsCont.style.cssText = "position:absolute;left:0px;top:0px;width:"+this._correction_x+"px;height:100%;";
	this.entBox.appendChild(this._rsCont);
	
	var trhCss = (_isIE&&_isIE<8?"position:absolute;":"height:auto;");
	
	this._rsCont.innerHTML = '<div class="xhdr" style="width:100%;height:'+this.hdrBox.style.height+';overflow:hidden;">'+
					'<table class="hdr" cellspacing="0" cellpadding="0" border="0" style="height:100%;table-layout:fixed;width:'+this._correction_x+'px;"><tbody>'+
						'<tr style="'+trhCss+'"><th style="height:0px;width:'+this._correction_x+'px;"></th></tr>'+
						'<tr><td style="border-right-width:1px!important;height:100%;"><div class="hdrcell">&nbsp;</div></td></tr>'+
					'</tbody></table>'+
				'</div>';
	//if (!this._rsRowsCont)
	this._rs_initData();
}

dhtmlXGridObject.prototype._rs_doOnSelectHandler = function(to) {
	for (var a in this._rsSel) this._rsSel[a] = false;
	for (var q=0; q<to.length; q++) this._rsSel[to[q]] = true;
	this._rs_doSelect();
}

dhtmlXGridObject.prototype._rs_setSizes = function() {
	
	this.objBox.style.width = parseInt(this.entBox.style.width)-this._correction_x+"px";
	this.hdrBox.style.width = this.objBox.style.width;
	this.objBox.style.marginLeft = this._correction_x+"px";
	this.hdrBox.style.marginLeft = this.objBox.style.marginLeft;
	
	if (this.ftr) {
		this.ftr.removeAttribute("width");
		this.ftr.style.width = this.hdrBox.style.width;
		this.ftr.parentNode.style.marginLeft = this.objBox.style.marginLeft;
	}
			
	this._rsCont.childNodes[0].style.height = this.hdrBox.style.height;
	if (this._rsRowsCont) this._rsRowsCont.style.height = this.objBox.style.height;
}

dhtmlXGridObject.prototype._rs_addRow = function(row, ind, fil, type) {
	
	if (!this._rsMaster) this._rs_initMaster();
	
	if (!this._rsObjBuf) this._rsObjBuf = {}; // id->obj
	if (!this._rsIdBuf) this._rsIdBuf = {}; // id->ind
	if (!this._rsIndBuf) this._rsIndBuf = {}; // ind->id
	
	var r = this._rsMaster.cloneNode(true);
	r.firstChild._rstd = true;
	r.idd = row.idd;
	
	if (this.multiLine) r.firstChild.style.height = row.offsetHeight+"px";
	
	if (!fil) {
		r.className = (ind%2==0?"ev_dhx_skyblue":"odd_dhx_skyblue");
		if (ind <= this._rsRowsCont.childNodes[0].childNodes[0].childNodes.length-1) {
			this._rsRowsCont.childNodes[0].childNodes[0].insertBefore(r,this._rsRowsCont.childNodes[0].childNodes[0].childNodes[ind]);
		} else {
			this._rsRowsCont.childNodes[0].childNodes[0].appendChild(r);
		}
	} else {
		r.className = row.className;
		if (type == "before") {
			fil._rsf.parentNode.insertBefore(r, fil._rsf);
		} else if (type == "after") {
			if (fil._rsf.nextSibling) fil._rsf.parentNode.insertBefore(r,fil._rsf.nextSibling); else fil._rsf.parentNode.appendChild(r);
		}
	}
	
	this._rsObjBuf[r.idd] = r;
	
	// check selection
	if (String(row.className).search("rowselected") >= 0) {
		r.className += " rowselected";
		this._rsSel[r.idd] = true;
	}
	
}

dhtmlXGridObject.prototype._rs_initMaster = function() {
	this._rsMaster = document.createElement("TR");
	this._rsMaster.appendChild(document.createElement("TD"));
	this._rsMaster.childNodes[0].className = "rowselector";
	this._rsMaster.childNodes[0].innerHTML = "<div class='rowselector2'><div class='rowselector3'></div><div class='rowselector4'></div></div>";
}

dhtmlXGridObject.prototype._rs_initData = function() {
	
	var trhCss = (_isIE&&_isIE<8?"position:absolute;":"height:auto;");
	
	this._rsRowsCont = document.createElement("DIV");
	this._rsRowsCont.className = "objbox";
	this._rsRowsCont.style.cssText = "width:"+this._correction_x+"px;overflow:hidden;height:"+this.objBox.style.height+";";
	this._rsRowsCont.innerHTML = '<table cellspacing="0" cellpadding="0" style="width'+this._correction_x+'px;table-layout:fixed;" class="obj row20px"><tbody>'+
						'<tr style="'+trhCss+'"><th style="height:0px;width:'+this._correction_x+'px;"></th></tr>'+
					'</tbody></table>';
	
	this._rsCont.appendChild(this._rsRowsCont);
	
	var thisGrid = this;
	this._rsRowsCont.onclick = function(e) {
		e = e||event;
		e.cancelBubble = true;
		var t = (e.target||e.srcElement);
		while (!(t._rstd == true || t == null)) t = t.parentNode;
		if (t._rstd == true && t.parentNode.idd != null) {
			var idd = t.parentNode.idd;
			thisGrid._rsLastCliked = idd;
			// autoclose editor
			if (thisGrid._rsAutoClose && thisGrid.editor) thisGrid.editStop();
			if (thisGrid.selMultiRows) {
				if (e.shiftKey||e.metaKey) {
					// define rows for select
					if (!thisGrid.lastClicked) thisGrid.lastClicked = thisGrid.rowsBuffer[thisGrid.getRowIndex(idd)];
					var t1 = thisGrid.getRowIndex(thisGrid.lastClicked.idd);
					var t2 = thisGrid.getRowIndex(idd);
					if (t1 > t2) { var t0 = t1; t1 = t2; t2 = t0; }
					for (var q=t1; q<=t2; q++) thisGrid._rsSel[thisGrid.rowsBuffer[q].idd] = true;
					thisGrid._rs_doSelect(false, true);
					return;
				}
				// update last clicked
				thisGrid.lastClicked = thisGrid.rowsBuffer[thisGrid.getRowIndex(idd)];
				if (e.ctrlKey) {
					// just add or remove clicked row into/from selection
					thisGrid._rsSel[idd] = (thisGrid._rsSel[idd]!==true);
					thisGrid._rs_doSelect(false, true);
					return;
				}
			}
			// simple select
			for (var a in thisGrid._rsSel) thisGrid._rsSel[a] = false;
			thisGrid._rsSel[idd] = true;
			thisGrid._rs_doSelect(idd);
			// call event
			thisGrid.callEvent("onRowSelectorClick",[idd]);
			
		}
	}
	
	
	if (this.ftr) {
		this._rsFtr = document.createElement("DIV");
		this._rsFtr.style.width = this._correction_x+"px";
		this._rsFtr.style.height = this.ftr.offsetHeight+"px";
		this._rsFtr.style.position = "relative";
		this._rsFtr.innerHTML = "<div class='ftr' style='height:100%;'><table cellspacing='0' cellpadding='0' border='0' width='100%' height='100%'><tbody><tr><td>&nbsp;</td></tr></tbody></table></div>";
		this._rsCont.appendChild(this._rsFtr);
	}
	
	// extra line if any
	if (this.lineBox) this._rs_initLineBox(true);
	
}
dhtmlXGridObject.prototype._rs_onScroll = function(x, y) {
	this._rsRowsCont.scrollTop = this.objBox.scrollTop;
}

dhtmlXGridObject.prototype._rs_clearSelection = function(skipGridUpdarte) {
	for (var a in this._rsSel) this._rsSel[a] = false;
	this._rs_doSelect();
	this.lastClicked = null;
	if (skipGridUpdarte !== true) this.clearSelection();
}

dhtmlXGridObject.prototype._rs_doSelect = function(toSelect, multiSelect) {
	
	// toSelect - predefined id to select
	// multiSelect - autoselect rows for multiselect mode
	if (!this._rsObjBuf) return;
	
	for (var a in this._rsSel) {
		var row = this._rsObjBuf[a];
		if (row) {
			var r = (multiSelect && this.selMultiRows ? this.rowsBuffer[this.getRowIndex(a)] : null);
			if (this._rsSel[a] === true) {
				var doSel = true;
				if (this.selMultiRows && this._rsLastClickedArrow) {
					doSel = (this._rsLastCliked == a);
				}
				if (doSel && String(row.className).search("rowselected") < 0) row.className += " rowselected";
				if (!doSel && String(row.className).search("rowselected") >= 0) row.className = String(row.className).replace(/rowselected/gi,"");
				if (r && String(r.className).search("rowselected") < 0) {
					r.className += " rowselected";
					if (this.selectedRows._dhx_find(r) < 0) this.selectedRows._dhx_insertAt(this.selectedRows.length, r);
				}
			} else {
				if (String(row.className).search("rowselected") >= 0) {
					row.className = String(row.className).replace(/rowselected/gi,"");
				}
				if (r && String(r.className).search("rowselected") >= 0) {
					r.className = String(r.className).replace(/rowselected/gi,"");
					this.selectedRows._dhx_removeAt(this.selectedRows._dhx_find(r));
				}
				delete this._rsSel[a];
			}
		}
	}
	
	if (toSelect && this._rsSel[toSelect] === true && this.getSelectedRowId() != toSelect) {
		this.selectRow(this.getRowIndex(toSelect), true);
	}
	
}

dhtmlXGridObject.prototype._rs_clearAll = function() {
	this._rs_clearSelection();
	this._rs_clearFillers();
	for (var a in this._rsObjBuf) this._rs_deleteRow(a, null, false);
}

dhtmlXGridObject.prototype._rs_deleteRow = function(id, pid, deleteOnly) {
	
	if (!this._rsObjBuf[id]) return;
	
	if (this._rsSel[id]) this._rsSel[id] = false;
	var ind = this._rs_getRowIndex(id);
	
	this._rsObjBuf[id].parentNode.removeChild(this._rsObjBuf[id]);
	this._rsObjBuf[id] = null;
	delete this._rsObjBuf[id];
	
	if (deleteOnly === false) return;
	this._rs_updateRows(ind);
}

dhtmlXGridObject.prototype._rs_updateRows = function(fromIndex) {
	var t = {1:"ev_dhx_skyblue",0:"odd_dhx_skyblue"};
	var w = fromIndex+1;
	for (var q=fromIndex+1; q<this._rsRowsCont.childNodes[0].childNodes[0].childNodes.length; q++) {
		var css = t[w%2];
		var css2 = t[1-w%2];
		var idd = this._rsRowsCont.childNodes[0].childNodes[0].childNodes[q].idd;
		if (idd != null) {
			if (String(this._rsObjBuf[idd].className).search(css) < 0) this._rsObjBuf[idd].className = String(this._rsObjBuf[idd].className).replace(css2,css);
			if (this._rsObjBuf[idd].style.display != "none") w++;
		}
	}
	
}

dhtmlXGridObject.prototype._rs_getRowIndex = function(id) {
	for (var q=1; q<this._rsRowsCont.childNodes[0].childNodes[0].childNodes.length; q++) {
		if (this._rsRowsCont.childNodes[0].childNodes[0].childNodes[q].idd == id) return q-1;
	}
	return -1;
}

dhtmlXGridObject.prototype._rs_setRowHidden = function(id, state) {
	if (!(state == (this._rsObjBuf[id].style.display == "none"))) {
		if (this._rsSel[id] == true) {
			// clear selection
			var r = this.rowsBuffer[this.getRowIndex(id)];
			if (r) {
				r.className = String(r.className).replace(/rowselected/gi,"");
				this.selectedRows._dhx_removeAt(this.selectedRows._dhx_find(r));
			}
			this._rsSel[id] = false;
		}
		this._rsObjBuf[id].style.display = (state?"none":"");
		this._rs_updateRows(0);
	}
}

// editmode behaviour
dhtmlXGridObject.prototype._rs_switchMode = function(mode, id) {
	if (mode == "edit" && id != this._rsEdit && this._rsObjBuf[id]) {
		this._rsObjBuf[id].childNodes[0].className = "rowselector editmode";
		this._rsEdit = id;
	} else if (mode == "read" && this._rsEdit && this._rsObjBuf[this._rsEdit]) {
		this._rsObjBuf[this._rsEdit].childNodes[0].className = "rowselector";
		this._rsEdit = null;
	}
}

// smart rendering
dhtmlXGridObject.prototype._rs_addFiller = function(pos, len, row, fil, rsflag) {
	var f = this._rsMaster.cloneNode(true);
	f.firstChild.style.height = row.firstChild.style.height;
	row._rsf = f;
	
		
		// from _addRow
		if (rsflag && fil && fil.nextSibling && !fil.tagName) {
			this._rsObjBuf[fil.nextSibling.idd].parentNode.insertBefore(f,this._rsObjBuf[fil.nextSibling.idd]);
			return;
		}
		if (rsflag && fil && fil.nextSibling && fil.nextSibling.idd == "__filler__" && row.nextSibling) {
			this._rsObjBuf[row.nextSibling.idd].parentNode.insertBefore(f,this._rsObjBuf[row.nextSibling.idd]);
			return;
		}
	
		// from _srnd
		if (fil && fil._rsf && fil._rsf.nextSibling) {
			fil._rsf.parentNode.insertBefore(f, fil._rsf.nextSibling);
		} else {
			this._rsRowsCont.childNodes[0].childNodes[0].appendChild(f);
		}
	
}

dhtmlXGridObject.prototype._rs_removeFiller = function(fil) {
	fil._rsf.parentNode.removeChild(fil._rsf);
	fil._rsf = null;
}

dhtmlXGridObject.prototype._rs_clearFillers = function() {
	if (!this._fillers) return;
	for (var q=0; q<this._fillers.length; q++) {
		if (this._fillers[q] != null) this._rs_removeFiller(this._fillers[q][2]);
	}
}

// extra line
dhtmlXGridObject.prototype._rs_initLineBox = function(mode) {
	if (mode && !this._rsLineBox) {
		this._rsLineBox = document.createElement("DIV");
		this._rsLineBox.innerHTML = "";
		this._rsLineBox.className = "objBox";
		this._rsRowsCont.appendChild(this._rsLineBox);
		return;
	}
	if (!mode && this._rsLineBox) {
		this._rsLineBox.parentNode.removeChild(this._rsLineBox);
		this._rsLineBox = null;
		return;
	}
}
dhtmlXGridObject.prototype._rs_resetLineBox = function() {
	
	if (!this._rsRowsCont) this._rs_initData();
	if (!this._rsMaster) this._rs_initMaster();
	if (!this._rsLineBox) this._rs_initLineBox();
	
	this._rsLineBox.innerHTML = "<table cellpadding='0' cellspacing='0' class='obj row20px' style='table-layout:fixed;'><tbody></tbody></table>";
	this._rsLineBox.firstChild.firstChild.appendChild(this._rsRowsCont.firstChild.firstChild.firstChild.cloneNode(true))
	this._rsLineBox.firstChild.firstChild.appendChild(this._rsMaster.cloneNode(true));
	this._rsLineBox.firstChild.firstChild.lastChild.firstChild.className += " extraline";
}
