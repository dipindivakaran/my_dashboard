class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_id
      t.string :password_hash
      t.string :first_name
      t.string :last_name
      t.string :salt
      t.string :persistance_tocken
      t.timestamps
    end
  end
end
