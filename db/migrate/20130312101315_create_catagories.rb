class CreateCatagories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :id
      t.string :title
      t.boolean :is_tab_item
      t.timestamps
    end
  end
end
