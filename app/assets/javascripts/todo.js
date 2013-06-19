
var categoryCount = 0;
var priorityCount = 0;
var source;
var selectedIndex = 1;
var rowIndex = 0;
var selectedItemIds = new Array();
var priorities = ["1","2","3"];

$(document).ready(function(){
	init_controls();
	$("#tasks_controls input").bind("keyup",function(e){
		source = get_categories_json();
		$(this).removeClass();
		if($(this).val().trim().length>0){
			$(this).addClass('show_loader');
			switch (e.keyCode) {
			case 13: 
			    if ($('.ui-autocomplete.ui-widget:visible').length == 0 ){
			    	 categoryCount = 0;
			         var todo = $(this).val();
			         if(todo.length>0){
			    	 post_todo(todo);
			    	 $(this).val('');
			    	 $(this).removeClass();
			    	 $("#status").removeClass().addClass('show_completed').fadeIn(1000).fadeOut(500);
			       }
			    }
			    return false;
			 case 49:
			     ++priorityCount;
			     console.log(priorityCount);
			     type = 'priority';
			     if(priorityCount==1){
			     	 load_autocomplete(priorities,type,"!");
			     }
			     return false;
			 case 51:
			     type = 'category';
			     ++categoryCount;
			     if(categoryCount==1){
			     	 load_autocomplete(source,type,"#");
			     }
			     return false;
	          }
		}else{
			categoryCount = 0;
			priorityCount = 0;
		}
    });
    
    $("#postpone").bind('click',function(){
    	var  attr = "postpone";
    	update_task_attribute(attr);
    });
    
    
     $("#completed").bind('click',function(){
     	var attr = "completed";
    	update_task_attribute(attr);
     });
     
     
     $("#task_input").focus(function(){
     	
     	if($(this).val().trim().length>0){
			$(this).addClass('show_loader');
		}else{
			$(this).removeClass();
		}
     	     	
     });
     
   function init_controls(){
  		categoryCount = 0;
		$("#tasks_controls input").val($("#tasks_controls input").attr('title'));
   		 $("#tasks_controls input").addClass('text-label');
	
		$("#tasks_controls input").focus(function(){
        	if( $("#tasks_controls input").val($("#tasks_controls input").attr('title'))) {
              $("#tasks_controls input").val('');
              $("#tasks_controls input").removeClass('text-label');
        	}
    	});
 		
    	 $("#tasks_controls input").blur(function(){
        	if( $("#tasks_controls input").val('')) {
            	 $("#tasks_controls input").val($("#tasks_controls input").attr('title'));
             	$("#tasks_controls input").addClass('text-label');
        	}
   		 });
	
		if($("#tasks_tabs").length > 0){
			$("#tab-list").html('');
			load_task_tab();
		}
    }
    
});


function update_task_attribute(attribute){
	var url = "/update_attribute?&attribute="+attribute;
	if(selectedItemIds.length>0){
    		$.ajax({
    			type: "POST",
   				url: url ,
   				data: JSON.stringify({'items': selectedItemIds}),
    			contentType: "application/json",
    			dataType: "json",
   				success: function(data){
			        get_all_posts(selectedIndex);
			     }
			 });
    	}else{
    		$("#dialog").dialog({
				dialogClass: "no-close",
				buttons: [
					{
					 text: "OK",
				     click: function() {
					 $(this).dialog( "close" );
					 }
					}
				]
               });
    	}
	
}


function load_autocomplete(source,type,key){
		$("#task_input").autocomplete({
			minLength: 0,
			source: function( request, response ) {
				response( $.ui.autocomplete.filter(
				source, extractLast( request.term ,key) ) );
			 	},
			 	autoFocus: true,
			focus: function() {
			  
			  return false;
			},
			position: { my : "left top", at: "left bottom" },
			select: function( event, ui ) {
			    var terms = split( this.value );
				terms.pop();
				terms.push( key + ui.item.value );
				terms.push( "" );
				this.value = terms.join( " " );
				$("#task_input").autocomplete("destroy");
				return false;
			}
		});
		
	
}


 function extractLast( term,key ) {
   return split(term).pop().replace(key,'');
 }

 function split( val ) {
  return val.split( / \s*/ );
 }


function post_todo(data){
 var url = "/post_todo?&category="+ selectedIndex;
 data = {'todo':data}
 $.ajax({
       type: "POST",
       dataType: "json",
       url: url,
       data: data,
       success: function(dolist){
            load_todo_list_items(dolist);
       }
    });
}

function get_all_posts(tabIndex){
 var url = "/get_posts?&tabIndex="+tabIndex;
 $.ajax({
       type: "POST",
       dataType: "json",
       url: url,
       success: function(dolist){
       	    JSON.stringify(dolist);
            load_todo_list_items(dolist);
       }
    });
	
}


function load_task_tab(){
		var url = "/get_tab_items";
		$.ajax({
			  dataType: "json",
			  url: url,	
			  success: function(data) {
			  		$.each(data,function(key,value){
						var tab = '<li><a href="#tabitem'+value.id+'">' + value.title + '</a></li>';
					    $("#tab-list").append(tab);
					    
	    			});
			  },
			  complete: function(){
			    $("#tasks_tabs").tabs({
			    	activate:function(event,ui){
			    		selectedItemIds = [];
			    		selectedIndex = parseInt($(this).tabs('option', 'active')+1);
			    		$.cookie('selectedTab',selectedIndex);
			    		get_all_posts(selectedIndex);
			    		rowIndex = 0;
			    	}
			    	
			    });
			    selectedIndex = parseInt($("#tasks_tabs").tabs('option', 'active'))+1;
			    if(!$.cookie('selectedTab')){
			    	$.cookie('selectedTab',selectedIndex);
			     }else{
			     	selectedIndex = $.cookie('selectedTab');
			     	$("#tasks_tabs").tabs({ active: --selectedIndex});
			     }
			  	$("#tasks_tabs").show();
			  	$("#tasks_tabs li a ui-id"+selectedIndex).focus();
			  	get_all_posts(selectedIndex);
			  }
		});
}

function get_categories_json(){
	   var categories = new Array();
		var url = "/get_categories";
		$.ajax({
			  dataType: "json",
			  url: url,	
			  success: function(data) {
			  		$.each(data,function(key,value){
			  			categories.push(value.title);
	    			});
			  },
			  complete: function(){
			    
			  }
			 
		});
	 return categories;
}


function load_todo_list_items(dolist){
	    rowIndex = 0;
	    selectedItemIds =  [];
	    var list_items = '';
	    $("#todo_list").html('');
	    var due_date
	 	$.each(dolist,function(key,todo){
	 		if(todo.due_date==null){
	 			due_date = '';
	 		}else{
	 			var today = new Date();
	 			var due = new Date(todo.due_date);
	 			
	 			var diff = (today - due)/(1000*24*60*60);
	 			if(Math.ceil(Math.abs(diff))<=7){
	 				due_date = $.datepicker.formatDate('DD', new Date(todo.due_date));
	 			}else if(Math.ceil(Math.abs(diff))<=30){
	 				due_date = $.datepicker.formatDate('MM dd', new Date(todo.due_date));
	 			}else{
	 				due_date = $.datepicker.formatDate('MM dd yy', new Date(todo.due_date));
	 			}
	 			
	 		}
       		list_items += '<tr><td class="item" width="100px"><input type="checkbox" id="'+ todo.id +'" class="todoitem"/></td><td width="500px">' + todo.catalog.replace('#','') + '</td><td width="200px"> ' + due_date +  '</td>' ;
       	});
       	list_items += '</tr>';
       	$("#todo_list").html(list_items);
       	$("tr:even").addClass("odd");
       	$(".todoitem").bind('click',function(){
    	if($(this).is(":checked")){
    		selectedItemIds.push($(this).attr('id'));
    	}else{
    		var index = $.inArray($(this).attr('id'), selectedItemIds);
			if(index != -1){
 			  selectedItemIds.splice(index, 1);
			}
    	}
    	
    });
    
      
}

