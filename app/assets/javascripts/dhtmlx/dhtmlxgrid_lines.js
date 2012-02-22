dhtmlXGridObject.prototype._init_pointLine = dhtmlXGridObject.prototype._init_point;
dhtmlXGridObject.prototype._init_point = function(){
	this._reset_extra_rows();
	if (this._init_pointLine) this._init_pointLine();
};
dhtmlXGridObject.prototype.enableExtraLine = function(mode, defVal){
	
	this._extra_lines = convertStringToBoolean(mode);
	
	this._extra_lines_def_vals = {};
	if (defVal != null) {
		for (var a in defVal) this._extra_lines_def_vals[a] = defVal[a];
	}
	
	if (!this._extra_lines) {
		if (this.lineBox){
			this.lineBox.parentNode.removeChild(this.lineBox);
			this.lineBox = null;
			this._correction_y = 0;
			this.setSizes();
			this.callEvent("onExtraLine",[false]);
		}
		return true;
	}
	if (this._extra_lines && this.lineBox) return;
	
	
//	this.attachEvent("onGridReconstructed", this._reset_extra_rows);
//	this.attachEvent("onXLE", this._reset_extra_rows);
	this.attachEvent("onEditCell", this._edit_extra_rows);
	this.attachEvent("onEditCancel", this._cancel_extra_rows);
	this.attachEvent("onSetSizes", this._reset_sizes);
	this.attachEvent("onTab", this._tab_extra_row);
	this.attachEvent("onLastRow", this._down_extra_row);
	
	this.smartTabOrder = true;
	this.lineBox = document.createElement("DIV");
	this.lineBox.innerHTML = "";
	this.lineBox.className = "objBox";
	this.objBox.appendChild(this.lineBox);
	
	this._correction_y = 18;
	
	this.callEvent("onExtraLine",[true]);
	
	if (this._cCount) {
		this._reset_extra_rows();
		this.setSizes();
	}
	
};
dhtmlXGridObject.prototype._reset_sizes = function(){
	if (!this._extra_lines) return true;
	if (!this.lineBox.firstChild) return;
	
	
	var row = this.lineBox.firstChild.firstChild.firstChild;
	this.lineBox.firstChild.style.width = this.obj.style.width;
	for (var i=0; i < this._cCount; i++)
		row.childNodes[i].style.width = this.cellWidthPX[i]+"px";
};
dhtmlXGridObject.prototype._reset_extra_rows = function(){
	if (!this._extra_lines) return true;
	if (!this.lineBox) return;
	this.lineBox.innerHTML ="<table cellpadding='0' cellspacing='0' class='obj row20px' style='table-layout:fixed;'><tbody></tbody></table>";
	var parent = this.lineBox.firstChild.firstChild;
	
	parent.appendChild(this.hdr.rows[0].cloneNode(true))
	var row = this._prepareRow("dhx_extra");
	this._fillRow(row, []);
	parent.appendChild(row);
	
	var grid = this;
	row.onclick = function(e){
		e = e||event;
		var target = e.target || e.srcElement;
		grid._add_extra_rows(target._cellIndex);
		(e||event).cancelBubble = true;
	};	
	this.callEvent("onResetExtraLines",[]);
	this._reset_sizes();
};
dhtmlXGridObject.prototype._add_extra_rows = function(index){
	if (!this._extra_lines) return true;
	if (this._fake_row_edit && this._is_empty(this._fake_row_edit))
		this._cancel_extra_rows();
	var id = this.uid();
	var data = [];
	for (var i=0; i < this._cCount; i++) data.push("");
	this.addRow(id, data);
	this.callEvent("onTempRecordAdd", [id])
	this.selectCell(this.getRowIndex(id),index, true);
	this.editStop();
	
	this._confirm_extra_rows();
		
	this._fake_row_edit = id;
	this._fake_row_cindex = index;
	this.editCell();
}
dhtmlXGridObject.prototype._confirm_extra_rows = function(){
	if (this._fake_row_edit)
		this.callEvent("onTempRecordConfirm", [this._fake_row_edit]);
	this._fake_row_edit = this._fake_row_cindex = null;
}
dhtmlXGridObject.prototype._edit_extra_rows = function(stage, id, ind, newval, oldval){
	if (!this._extra_lines) return true;
	
	if (stage == 0 && this._fake_row_edit){
		if (id != this._fake_row_edit){
			if (this._is_empty(this._fake_row_edit)){
				this._cancel_extra_rows();
			} else 
				this._confirm_extra_rows();
				
			this._fake_row_edit = this._fake_row_cindex = null;
		}
	}
	return true;
};
dhtmlXGridObject.prototype._cancel_extra_rows = function(){
	if (!this._extra_lines) return true;
	
	if (this._fake_row_edit){
		var tempedit = null;
		if (this.editor && this.editor.cell.parentNode.idd != this._fake_row_edit){
			tempedit = this.editor;
			this.editor = null;
		}
		this.deleteRow(this._fake_row_edit);
		this.editor = tempedit;
		
		this.callEvent("onTempRecordDelete", [this._fake_row_edit]);
		this._fake_row_edit = this._fake_row_cindex = null;
	}
};
dhtmlXGridObject.prototype._is_empty = function(id){
	for (var i=0; i < this._cCount; i++) {
		var v = this.cells(id, i).getValue();
		var e = (this.columnIds&&this.columnIds[i]&&this._extra_lines_def_vals&&this._extra_lines_def_vals[this.columnIds[i]]==v?true:(v==""));
		if (!e) return false;
	};
	return true;
}
dhtmlXGridObject.prototype._tab_extra_row = function(mode){
	if (!this._extra_lines) return true;
	
	//debugger;
	if (!this.rowsAr[this.row.idd]){
		if (this.cell){
			if (this.cell._cellIndex == 0 && !mode){
				if (this.rowsBuffer.length && this.rowsBuffer[this.rowsBuffer.length-1])
					this.selectCell(this.rowsBuffer.length-1, this._cCount-1, false, false, false);
				return true;
			}
			this._add_extra_rows(Math.min(this._cCount-1, this.cell._cellIndex +1*(mode?1:-1)));
			return false;
		}
	} else {
		if (mode){
			var z = this._getNextCell(null, 1);
			if (!z){
				this._add_extra_rows(0);
				return false;
			}
		}
	} 
	return true;
};

dhtmlXGridObject.prototype._down_extra_row = function(){
	if (!this._extra_lines) return true;
	
//	if (this.cell && this.cells4(this.cell).isDisabled()) return;
	this.editStop();
	this._add_extra_rows(this.cell?this.cell._cellIndex:0);
};

