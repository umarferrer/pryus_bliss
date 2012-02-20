// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {

	$( "#li_connexion" ).click(function() {
				$( "#connexion" ).dialog( "open" );
			});

	$( "#connexion" ).dialog({
		autoOpen: false,
		draggable:false,
		resizable:false,
		title:"Identification",
		width :265,
	});


	$( "#index_menu" ).accordion({
			//event: "mouseover"
			collapsible: true,
			active: false,
			

		});

	$('.table_machines').hover(function(){
		$(this).find(".infobull p").fadeIn();
		//$('.infobull p').show();
	}, function(){
		$(".infobull p").hide();
	});

})