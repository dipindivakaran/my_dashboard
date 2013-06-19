class CategoryMap < ActiveRecord::Base
  belongs_to :todo_list , {:foreign_key => "todo_id"}
  belongs_to :category , {:foreign_key => "category_id"}
  attr_accessible :id ,:category_id ,:todo_id
end
