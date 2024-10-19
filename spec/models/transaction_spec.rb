require 'rails_helper'

RSpec.describe Transaction, type: :model do

  context 'validations' do
    it 'returns an error if wallet_id is nil' do
      transaction = Transaction.new(
        transaction_type: :credit,
        amount: 10000
      )
      expect(transaction).to_not be_valid
    end

    it 'returns an error if amount is equal or less than 0' do
      wallet = Wallet.new(
        id: 1
      )
      transaction = Transaction.new(
        transaction_type: :credit,
        amount: 0,
        wallet: wallet
      )

      expect(transaction).to_not be_valid
    end
  end
end
