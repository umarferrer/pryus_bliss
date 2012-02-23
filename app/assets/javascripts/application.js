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

	// $('.table_machines').hover(function(){
	// 	$(this).find(".infobull #ipdesc").fadeIn();
	// }, function(){
	// 	$(".infobull #ipdesc").hide();
	// });
	// $('.table_machines').hover(function(){
	// 	$(this).find(".infobull #ipdescerr").fadeIn();
	// }, function(){
	// 	$(".infobull #ipdescerr").hide();
	// });

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
			$(".signed_in_li_machines").css('top' , '0px ');
		}
	});

	$( ".signed_in_ul_machines" ).droppable({
		activeClass: "ui-state-default-perso",
		hoverClass: "ui-state-hover-perso",
		drop: function( event, ui ) {
			$( ui.draggable ).addClass("deplaced");
			$( this ).addClass("deplaced_ici");		
			$.ajax({
				url: "/update_machine?id="+$( ui.draggable).attr("id_machine")+"&salle="+$( this ).attr("id_salle") ,
				success:function(data){
					if ( data.search(/ajaxok/i) != -1 ) { 
						$(".deplaced").appendTo( ".deplaced_ici" );
						$(".deplaced_ici").find(".separateur").appendTo( ".deplaced_ici" );
						$(".deplaced").removeClass("deplaced");
						$(".deplaced_ici").removeClass("deplaced_ici");
						refresh_menu();
					}
					else if ( data.search(/404salle/i) != -1 ) {
						alert("Oups votre salle a disparu !");
					}
					else {
						window.location.replace("/signin");
					}
				}			
			});						
		}
	});

	function refresh_menu() {		
		$.ajax({
				url: "/update_menu" ,
				success:function(data){
					$("#index_menu").html(data);
						
						$( "#index_menu" ).accordion( "destroy" );
						$( "#index_menu" ).accordion({
							collapsible: true,
							active: false,			
						});				
				}			
		});
	};

	$('#seuils input').keyup(function() {
		if ( $("#warning").val() != "" && $("#critical").val() != "" && $.isNumeric( $("#warning").val() ) && $.isNumeric( $("#critical").val() ) ) {
			$("#hide_salle").slideDown();
		}
		else {
			$("#hide_salle").slideUp();
		}
	});

	$('.table_machines_incident').hover(function(){
		$(this).find(".infobull p").fadeIn();
	}, function(){
		$(".infobull p").hide();
	});

	$( ".signed_in_li_machines_o" ).draggable({ 
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
			$(".signed_in_li_machines").css('top' , '0px ');
		}
	});

	$( ".signed_in_ul_machines_o" ).droppable({
		activeClass: "ui-state-default-perso",
		hoverClass: "ui-state-hover-perso",
		drop: function( event, ui ) {
			$( ui.draggable ).addClass("deplaced");
			$( this ).addClass("deplaced_ici");				
			$(".deplaced").appendTo( ".deplaced_ici" );
			$(".deplaced_ici").find(".separateur").appendTo( ".deplaced_ici" );
			$(".deplaced").removeClass("deplaced");
			$(".deplaced_ici").removeClass("deplaced_ici");
			if ( $(".full_machine").index() == 1 ) {
				$(".full_machine").removeClass('full_machine');
				$("#amuse_toi").slideUp();
			}
		}
	});
	$( ".signed_in_ul_machines_ol" ).droppable({
		activeClass: "ui-state-default-perso",
		hoverClass: "ui-state-hover-perso",
		drop: function( event, ui ) {
			$( ui.draggable ).addClass("deplaced");
			$( this ).addClass("deplaced_ici");				
			if ( $(".full_machine").index() == -1 ) {
				$(".deplaced_ici").addClass('full_machine');
				$(this).droppable( "option", "accept", ":not(.dontmoveme)" );
				$(".deplaced").appendTo( ".deplaced_ici" );
				$(".deplaced_ici").find(".separateur").appendTo( ".deplaced_ici" );
				$(".deplaced").removeClass("deplaced");
				$(".deplaced_ici").removeClass("deplaced_ici");
				$("#amuse_toi").slideDown();				
				if ( $(".salles_incident_conf #nom_de_la_machine").attr("ping") == "0" ){						
					$("#pingonoff").attr("checked",false);
					$('#pingonoff').iphoneStyle("refresh");
				}
				else if ( $(".salles_incident_conf #nom_de_la_machine").attr("ping") == "1" ){						
					$("#pingonoff").attr("checked",true);
					$('#pingonoff').iphoneStyle("refresh");
				}
				if ( $(".salles_incident_conf #nom_de_la_machine").attr("service") == "0" ){
					$.ajax({
						url :"/get_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/Memory",
						success:function(data){
							if ( data.search(/none/i) != -1 ) {
								$( "#slider_ram" ).slider( "value" , 0 );
								$( "#amount_ram" ).html( 0 + "%");
							}
							else {							
								$( "#slider_ram" ).slider( "value" , data );
								$( "#amount_ram" ).html( data + "%");
							}
						}			
					});
					$.ajax({
						url :"/get_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/Cpu",
						success:function(data){
							if ( data.search(/none/i) != -1 ) {
								$( "#slider_cpu" ).slider( "value" , 0 );
								$( "#amount_cpu" ).html( 0 + "%");
							}
							else {							
								$( "#slider_cpu" ).slider( "value" , data );
								$( "#amount_cpu" ).html( data + "%");
							}
						}			
					});
				}
				else if ( $(".salles_incident_conf #nom_de_la_machine").attr("service") == "1" ){
					$( "#slider_cpu" ).slider( "value" , 0 );
					$( "#amount_cpu" ).html( 0 + "%");
					$( "#slider_ram" ).slider( "value" , 0 );
					$( "#amount_ram" ).html( 0 + "%");					
				}
			}							
		}
	});
	$('#pingonoff').iphoneStyle({
		uncheckedLabel: 'off',
		checkedLabel: 'on',
		onChange: function(elem, value) {	
			if ( value.toString() == "true" ) {		
				$.ajax({
				url :"/update_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/Ping",
				success:function(data){
					if ( data.search(/ajaxok/i) != -1 ) {}
					else if ( data.search(/none/i) != -1 ) {}
					else {
						alert("Oups");
					}
					update_li();
				},
				error:function(data){
					alert("Oups");
				}			
				});			
			}
			else if ( value.toString() == "false" ) {
				$.ajax({
					url :"/new_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/1/C/Injoignable/Ping",
					success:function(data){
						if ( data.search(/ajaxok/i) != -1 ) {}
						else if ( data.search(/already/i) != -1 ) {}
						else {
							alert("Oups");
						}
						update_li();
					},
					error:function(data){
						alert("Oups");
					}			
				});	
			}
		}
	});
	$( "#slider_ram" ).slider({
		value:0,
			min: 0,
			max: 100,
			step: 1,
			slide: function( event, ui ) {
				$( "#amount_ram" ).html( ui.value + "%");
			},
			stop: function( event, ui ) {

				if ( ui.value >= $("#critical").val() ) {
					$.ajax({
						url :"/new_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/2/C/"+ui.value+"/Memory",
						success:function(data){
							if ( data.search(/ajaxok/i) != -1 ) {}
							else if ( data.search(/already/i) != -1 ) {
								alert("Conflit avec Cpu");
								$( "#slider_ram" ).slider( "value" , 0 );
								$( "#amount_ram" ).html( 0 + "%");
							}
							else {
								alert("Oups");
								$( "#slider_ram" ).slider( "value" , 0 );
								$( "#amount_ram" ).html( 0 + "%");
							}
							update_li();
						},
						error:function(data){
							alert("Oups");
							$( "#slider_ram" ).slider( "value" , 0 );
							$( "#amount_ram" ).html( 0 + "%");
							update_li();
						}			
					});						
				}
				else if ( ui.value >= $("#warning").val() ) {
					$.ajax({
						url :"/new_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/2/W/"+ui.value+"/Memory",
						success:function(data){
							if ( data.search(/ajaxok/i) != -1 ) {}
							else if ( data.search(/already/i) != -1 ) {
								alert("Conflit avec Cpu");
								$( "#slider_ram" ).slider( "value" , 0 );
								$( "#amount_ram" ).html( 0 + "%");
							}
							else {
								alert("Oups");
								$( "#slider_ram" ).slider( "value" , 0 );
								$( "#amount_ram" ).html( 0 + "%");
							}
							update_li();
						},
						error:function(data){
							alert("Oups");
							$( "#slider_ram" ).slider( "value" , 0 );
							$( "#amount_ram" ).html( 0 + "%");
							update_li();
						}			
					});	
				}
				else {	
					$.ajax({
						url :"/update_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/Memory",
						success:function(data){
							if ( data.search(/ajaxok/i) != -1 ) {}
							else if ( data.search(/none/i) != -1 ) {}
							else {
								alert("Oups");
							}
							update_li();
						},
						error:function(data){
							alert("Oups");
							update_li();
						}			
					});	
				}											
			}
	});
	$( "#amount_ram" ).html( $("#slider_ram").slider("value")+"%");
	$( "#slider_cpu" ).slider({
		value:0,
			min: 0,
			max: 100,
			step: 1,
			slide: function( event, ui ) {
				$( "#amount_cpu" ).html( ui.value + "%");
			},
			stop: function( event, ui ) {				
				if ( ui.value >= $("#critical").val() ) {
					$.ajax({
						url :"/new_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/2/C/"+ui.value+"/Cpu",
						success:function(data){
							if ( data.search(/ajaxok/i) != -1 ) {}
							else if ( data.search(/already/i) != -1 ) {
								alert("Conflit avec Memory!");
								$( "#slider_cpu" ).slider( "value" , 0 )
								$( "#amount_cpu" ).html( 0 + "%");
							}
							else {
								alert("Oups");
								$( "#slider_cpu" ).slider( "value" , 0 )
								$( "#amount_cpu" ).html( 0 + "%");
							}
							update_li();
						},
						error:function(data){
							alert("Oups");
							$( "#slider_cpu" ).slider( "value" , 0 )
							$( "#amount_cpu" ).html( 0 + "%");
							update_li();
						}			
					});						
				}
				else if ( ui.value >= $("#warning").val() ) {
					$.ajax({
						url :"/new_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/2/W/"+ui.value+"/Cpu",
						success:function(data){
							if ( data.search(/ajaxok/i) != -1 ) {}
							else if ( data.search(/already/i) != -1 ) {
								alert("Conflit avec Memory");
								$( "#slider_cpu" ).slider( "value" , 0 );
								$( "#amount_cpu" ).html( 0 + "%");
							}
							else {
								alert("Oups");
								$( "#slider_cpu" ).slider( "value" , 0 );
								$( "#amount_cpu" ).html( 0 + "%");
							}
							update_li();
						},
						error:function(data){
							alert("Oups");
							$( "#slider_cpu" ).slider( "value" , 0 );
							$( "#amount_cpu" ).html( 0 + "%");
							update_li();
						}			
					});	
				}
				else {

					$.ajax({
						url :"/update_incident/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine")+"/Memory",
						success:function(data){
							if ( data.search(/ajaxok/i) != -1 ) {}
							else if ( data.search(/none/i) != -1 ) {}
							else {
								alert("Oups");
							}
							update_li();
						},
						error:function(data){
							alert("Oups");
							update_li();
						}			
					});	
				}			
			}
	});
	$( "#amount_cpu" ).html( $("#slider_cpu").slider("value")+"%");

	$('#hide_salle').hide();
	$('#amuse_toi').hide();

	function update_li(statut) {
		$.ajax({
			url :"/etat_machine/"+$(".salles_incident_conf #nom_de_la_machine").attr("machine"),
			success:function(data){			
				substr = data.split('+');
				if ( substr[0]=="0" ) {
					$(".salles_incident_conf #nom_de_la_machine").attr("ping",substr[0]);
				}
				else if ( substr[0]=="1" ) {
					$(".salles_incident_conf #nom_de_la_machine").attr("ping",substr[0]);
				}

				if ( substr[1]=="0" ) {
					$(".salles_incident_conf #nom_de_la_machine").attr("service",substr[1]);				
				}
				else if ( substr[1]=="1" ) {
					$(".salles_incident_conf #nom_de_la_machine").attr("service",substr[1]);				
				}
			},
			error:function(data){
				alert("Oups");
			}			
		});
	}
})