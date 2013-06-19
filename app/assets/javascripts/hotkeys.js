

$(document).bind('keydown',function(e){
	 arrow = {left: 37, up: 38, right: 39, down: 40 };
	 action_keys = {completed:67,postpone:88};
	  if (e.keyCode == arrow.right && e.ctrlKey) {
            if(selectedIndex < 4){
            	++selectedIndex;
            	$("#tasks_tabs").tabs({ active: --selectedIndex});
            }
        }else if (e.keyCode == arrow.left && e.ctrlKey) {
            if(selectedIndex > 1){
            	--selectedIndex;
            	$("#tasks_tabs").tabs({ active: --selectedIndex});
            }
        }else if (e.keyCode == arrow.down && e.ctrlKey) {
        	if(rowIndex%2!=0){
        	   $("#todo_list tr:nth-child(" + rowIndex + ")").addClass('odd');
        	 }
        	 ++rowIndex;
        	 $("#todo_list tr").removeClass('active');
        	 $("#todo_list tr:nth-child(" + rowIndex + ")").removeClass('odd');
        	 $("#todo_list tr:nth-child(" + rowIndex + ")").addClass('active'); 
        	 $("#todo_list tr:nth-child(" + rowIndex + ")").find("input").focus();
        	
        }else if (e.keyCode == arrow.up && e.ctrlKey) {
        	 $("#todo_list tr:nth-child(" + rowIndex + ")").removeClass();
        	 if(rowIndex%2!=0){
        	   $("#todo_list tr:nth-child(" + rowIndex + ")").addClass('odd');
        	 }
        	 --rowIndex;
           	 $("#todo_list tr:nth-child(" + rowIndex + ")").removeClass();
             $("#todo_list tr:nth-child(" + rowIndex + ")").addClass('active');
             $("#todo_list tr:nth-child(" + rowIndex + ")").find("input").focus();
        }else if (e.keyCode == action_keys.completed && e.ctrlKey) {
             $("#completed").click();	
        }else if (e.keyCode == action_keys.postpone && e.ctrlKey) {
             $("#postpone").click();	
        }
        
	
	
});