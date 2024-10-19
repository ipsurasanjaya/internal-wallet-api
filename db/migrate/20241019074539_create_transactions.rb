class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :type, default: 0
      t.float :amount
      t.belongs_to :wallet, foreign_key: true, index: { unique: true }
      t.timestamps
    end
  end
end
