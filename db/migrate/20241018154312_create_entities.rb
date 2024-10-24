class CreateEntities < ActiveRecord::Migration[7.2]
  def change
    create_table :entities do |t|
      t.string :type
      t.string :name
      t.string :email
      t.string :password_digest
      
      t.timestamps
    end
  end
end
