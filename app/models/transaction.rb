class Transaction < ApplicationRecord
    belongs_to :wallet

    validates :wallet, presence: true
    validates :amount, numericality: true, comparison: { greater_than: 0 }
    validate :balance_cannot_be_negative

    enum :transaction_type, {
        credit: 0,
        debit: 1
    }

    def balance_cannot_be_negative
        return unless wallet
        balance = wallet.transactions.sum(:amount)

        if balance < amount && transaction_type == "credit"
            errors.add(:amount, "insufficient funds: current balance is less than the transaction amount")
        end
    end
end

class TopUpTransaction < Transaction 
    def create_transaction(credit_wallet, debit_wallet, operation_type, amount)
        transaction = Transaction.new(
            wallet: debit_wallet,
            transaction_type: :debit,
            amount: amount,
            operation_type: "TOP-UP"
        )

        if transaction.save 
            transaction
        else 
            raise ActiveRecord::RecordInvalid, transaction
        end
    end
end

class TransferTransaction < Transaction 
    def create_transaction(credit_wallet, debit_wallet, operation_type, amount)
        credit_transaction = Transaction.new(
            wallet: credit_wallet,
            transaction_type: :credit,
            amount: amount,
            operation_type: "TRANSFER"
        )

        if credit_transaction.save 
            credit_transaction
        else 
            raise ActiveRecord::RecordInvalid, credit_transaction
        end

        debit_transaction = Transaction.new(
            wallet: debit_wallet,
            transaction_type: :debit,
            amount: amount,
            operation_type: "TRANSFER"
        )

        if debit_transaction.save 
            debit_transaction
        else 
            raise ActiveRecord::RecordInvalid, debit_transaction
        end
    end
end
