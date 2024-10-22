class Transaction < ApplicationRecord
    belongs_to :wallet

    validates :wallet, presence: true
    validates :amount, numericality: true, comparison: { greater_than: 0 }

    enum :transaction_type, {
        credit: 0,
        debit: 1
    }

    def self.get_balance(wallet)
        total_debit_amount = wallet.transactions.where(transaction_type: 1).sum(:amount)
        total_credit_amount = wallet.transactions.where(transaction_type: 0).sum(:amount)

        balance = total_debit_amount - total_credit_amount
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

        credit_balance = get_balance(credit_wallet)
        if credit_balance - amount < 0
            raise "insufficient funds"
        end

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
