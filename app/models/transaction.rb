class Transaction < ApplicationRecord
    belongs_to :wallet

    validate :balance_cannot_be_negative
    validates :wallet, presence: true
    validates :amount, numericality: true, comparison: { greater_than: 0 }

    enum :transaction_type, {
        credit: 0,
        debit: 1
    }

    def balance_cannot_be_negative
        balance = wallet.transactions.sum(:amount)
        if balance < amount && credit?
            errors.add(:amount, "insufficient funds: current balance is less than the transaction amount")
        end
    end
end
