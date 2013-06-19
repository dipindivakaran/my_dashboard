class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :category
      t.string :catalog
      t.string :status
      t.integer :priority
      t.date :due_date
      t.references :category_maps
      t.timestamps
    end
  end
end
