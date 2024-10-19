class Transaction < ApplicationRecord
    belongs_to :wallet

    validates :wallet, presence: true
    validates :amount, numericality: true, comparison: { greater_than: 0 }

    enum :transaction_type, {
        credit: 0,
        debit: 1
    }
end
