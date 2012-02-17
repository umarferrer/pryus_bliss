dhtmlXGridObject.prototype.enableDomCleaning = function(counter, check){
	
	var max_counter = counter||50;
	var check_each = check||5;
	this.attachEvent("onScroll", function(left, top){
		var counter = 0;
		if (check_each <2 || (new Date())%check_each){
			for (var i=0; i<this.rowsCol.length; i++){
				if (this.rowsCol[i]) counter++;
				if (counter > max_counter) 
					return this._reset_dom(left, top);
			}
		}
	});
	
	this._reset_dom = function(left, top){
		this.objBox.onscroll=null;
		
		for (var i=0; i<this.rowsCol.length; i++)
			if (this.rowsCol[i])
				this.rowsCol[i].className = "";
		this._reset_view();
		
		if (this._rsMode) {
			var t = this;
			window.setTimeout(function(){t._rs_onScroll();},100);
		}
		
		window.setTimeout(this._reset_scroll(),100);
	
		this.objBox.scrollLeft = left||0;
		this.objBox.scrollTop = top||0;
	};
	this._reset_scroll = function(){
		var that = this;
		return function(){ 
			that.objBox.onscroll = function(){
				this.grid._doOnScroll();
			};
		}
	}
	
}

