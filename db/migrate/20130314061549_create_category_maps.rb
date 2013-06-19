class CreateCategoryMaps < ActiveRecord::Migration
  def change
    create_table :category_maps do |t|
      t.integer :category_id
      t.integer :todo_id
      t.integer :id
      t.references :todo_list
      t.references :category
      t.timestamps
    end
  end
end
