class TodoList < ActiveRecord::Base
  has_many :category_maps ,:autosave => true
  attr_accessible :category, :catalog, :due_date, :priority , :status
end
