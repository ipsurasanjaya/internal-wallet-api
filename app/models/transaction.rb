class Transaction < ApplicationRecord
    belongs_to :wallet

    validates :wallet, presence: true

    enum :transaction_type, {
        credit: 0,
        debit: 1
    }
end
