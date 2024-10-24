class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type, default: 0
      t.float :amount
      t.string :operation_type
      t.string :stock_id
      t.belongs_to :wallet, foreign_key: true, null: false
      t.timestamps
    end
  end
end
