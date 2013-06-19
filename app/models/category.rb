class Category < ActiveRecord::Base
  attr_accessible :id,:title, :is_tab_item
  has_many :category_maps
end
