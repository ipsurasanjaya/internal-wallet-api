class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|

      t.belongs_to :entity, foreign_key: true, index: { unique: true } 
      t.timestamps
    end
  end
end
