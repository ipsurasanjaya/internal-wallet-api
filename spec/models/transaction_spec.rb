require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'validations' do
    it 'returns an error if wallet_id is nil' do
      transaction = Transaction.new(
        transaction_type: :credit,
        amount: 10000
      )

      expect(transaction).to_not be_valid
      expect(transaction.errors[:wallet]).to include("can't be blank")
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
      expect(transaction.errors[:amount]).to include("must be greater than 0")
    end

    it 'returns an error if amount is not a number' do
      wallet = Wallet.new(
        id: 1
      )
      transaction = Transaction.new(
        transaction_type: :credit,
        amount: 'invalid_amount',
        wallet: wallet
      )

      expect(transaction).to_not be_valid
      expect(transaction.errors[:amount]).to include("is not a number")
    end
  end
end
