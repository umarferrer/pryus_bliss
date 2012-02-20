//v.3.0 build 110713

/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
You allowed to use this component or parts of it under GPL terms
To use it on other terms or get Professional edition of the component please contact us at sales@dhtmlx.com
*/
function eXcell_link(a){this.cell=a;this.grid=this.cell.parentNode.grid;this.isDisabled=function(){return!0};this.edit=function(){};this.getValue=function(){return this.cell.firstChild.getAttribute?this.cell.firstChild.innerHTML+"^"+this.cell.firstChild.getAttribute("href"):""};this.setValue=function(a){if(typeof a!="number"&&(!a||a.toString()._dhx_trim()==""))return this.setCValue("&nbsp;",b),this.cell._clearCell=!0;var b=a.split("^");b.length==1?b[1]="":b.length>1&&(b[1]="href='"+b[1]+"'",b[1]+=
b.length==3?" target='"+b[2]+"'":" target='_blank'");this.setCValue("<a "+b[1]+" onclick='(_isIE?event:arguments[0]).cancelBubble = true;'>"+b[0]+"</a>",b)}}eXcell_link.prototype=new eXcell;eXcell_link.prototype.getTitle=function(){var a=this.cell.firstChild;return a&&a.tagName?a.getAttribute("href"):""};eXcell_link.prototype.getContent=function(){var a=this.cell.firstChild;return a&&a.tagName?a.innerHTML:""};

//v.3.0 build 110713

/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
You allowed to use this component or parts of it under GPL terms
To use it on other terms or get Professional edition of the component please contact us at sales@dhtmlx.com
*/