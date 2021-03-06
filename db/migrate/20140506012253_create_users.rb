class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :salt
      t.text :hashed_password

      t.timestamps
    end
  end
end
