require 'rails_helper'

RSpec.describe Transaction, type: :model do

  context 'validations' do
    it 'returns an error if wallet_id is nil' do
      transaction = Transaction.new(
        transaction_type: :credit,
        amount: 10000
      )
      expect(transaction).to_not be_valid
      expect(transaction.errors[:wallet]).to include("can't be blank") 
    end
  end
end
