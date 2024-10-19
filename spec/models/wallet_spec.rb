require 'rails_helper'

RSpec.describe Wallet, type: :model do

  context 'validations' do
    it 'returns error when wallet is not found' do
      expect { Wallet.find_wallet(-1) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns wallet when the wallet exist' do
      wallet = double('Wallet', id: 1, user_id: 1)
      allow(Wallet).to receive(:find).with(1).and_return(wallet)

      result = Wallet.find_wallet(1)
      expect(result).to eq(wallet)
    end
  end
end
