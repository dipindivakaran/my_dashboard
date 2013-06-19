class TodoListsController < ApplicationController
  
  $TAB_INDEX = 1
  $PENDING = 'pending'
  $COMPLETED = 'completed'
  $POSTPONE = 'postpone'
  
  before_filter :login_required, :only=>['post_todo', 'get_posts', 'update_attribute','home']
  
  
  def post_todo
    $TAB_INDEX = params[:category]
    category_count = 0
    priority = 3
    todo_task = TodoList.new
    cat_array = Array.new
    due_date = nil
    task_input = ""
    tockens =  params[:todo].split(" ")
    tockens.each do |tocken|
    date_tocken = Date.parse(tocken) rescue nil  
    if(tocken[0].chr=="#")
        category_count+= 1
        cate_map = CategoryMap.new
        keyword = tocken.split("#")[1]
        category = Category.where("lower(title) = ?",keyword.downcase).first
        if(category.present?)
           cate_map.category = category
           cat_array.push(cate_map)
        else
          category = Category.new
          category.is_tab_item = false
          category.title = keyword
          category.save
        end        
         cate_map.category = category
         cat_array.push(cate_map)
         
     elsif (tocken[0].chr=="!")
       priority = tocken.split("!")[1]
       
     elsif(date_tocken)
          due_date = date_tocken
     else
       task_input +=  tocken.gsub(/[^0-9A-Za-z\\\/]/, '') + " "   
       if(tocken.upcase == 'TODAY')
          due_date = Date.today
       elsif (tocken.upcase == 'TOMORROW')
         due_date = Date.tomorrow
       end 
     end
    end
    if(category_count==0)
      cate_map = CategoryMap.new
      cate_map.category = Category.where("id=?",$TAB_INDEX).first
      cat_array.push(cate_map)
    end
     todo_task.due_date = due_date
     todo_task.category_maps << cat_array
     todo_task.catalog = task_input
     todo_task.status = $PENDING
     todo_task.priority = priority
     todo_task.save
     redirect_to get_posts_url
   end
  
  def get_posts
    @tabIndex = params[:tabIndex]
    if !@tabIndex.present?
      @tabIndex = $TAB_INDEX
    end
    @todo = Array.new
    if(@tabIndex=="4")
       @todo = TodoList.where("status != 'completed'").order("priority ASC")
     else
       @todo = TodoList.includes(:category_maps).where("category_maps.category_id=?", @tabIndex).where("status != 'completed'").order("priority ASC")
    end
    respond_to do |format|
    format.html
    format.json{
      render :json => @todo.to_json
    }
    end
  end
  
  def home
      
  end
  
  def update_attribute
    @attribute = params[:attribute]
    @item_ids = params[:items]
    task_array = Array.new
    todo_lists = TodoList.where("id IN (?)", @item_ids)
    todo_lists.each do |task|
      if @attribute == $POSTPONE
        if task.due_date.present?
         task.due_date = task.due_date + 1.day
       else
         task.due_date = Date.tomorrow
       end
       else
         task.status = $COMPLETED
      end
       if task.save
         task_array.push(task)
       end
    end
    respond_to do |format|
    format.html
    format.json{
      render :json => @todo.to_json
    }
    end
    
  end
  
end
