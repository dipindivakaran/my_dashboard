class CategoriesController < ApplicationController
 
 
  def get_categories
    @categories = Category.find(:all,:order=>'id ASC')
    respond_to do |format|
    format.html
    format.json{
      render :json => @categories.to_json
    }
    end
  end
  
  def get_tab_items
    @categories = Category.where('is_tab_item = ?',true).order('id ASC')
    respond_to do |format|
    format.html
    format.json{
      render :json => @categories.to_json
    }
    end
  end
  
  
  
end
