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
		collapsible: true,
		active: false,
	});

	$('.table_machines').hover(function(){
		$(this).find(".infobull p").fadeIn();
	}, function(){
		$(".infobull p").hide();
	});

	$( ".signed_in_li_machines" ).draggable({ 
		containment: "#index_salles",
		scroll: true, 
		scrollSpeed: 10,
		revert: true,
		cursor: 'move',	
		zIndex: 10,
		start: function(event, ui) {		
			$(this).addClass("dontmoveme");
			$(this).parent().droppable( "option", "accept", ":not(.dontmoveme)" );
			$(this).parent().addClass("dontmovemediv") ;			
		},
		stop: function(event, ui) {		
			$(this).removeClass("dontmoveme");
			$(".dontmovemediv").droppable( "option", "accept", "*" );
			$(".dontmovemediv").removeClass("dontmovemediv");
		}
	});

	$( ".signed_in_ul_machines" ).droppable({
		activeClass: "ui-state-default-perso",
		hoverClass: "ui-state-hover-perso",
		drop: function( event, ui ) {
			$( ui.draggable ).addClass("deplaced");
			$(".deplaced").appendTo( this );
			$(this).find(".separateur").appendTo( this );
			$(".deplaced").removeClass("deplaced");
		}
	});



	$( "#plop" ).click(function() {
		
		$.ajax({
			url: "/update_machine?id=2&salle=5",
			success: function(){
				
			}
		});
	});

})