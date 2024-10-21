class WalletTransactionService
    def initialize(credit_wallet_id, debit_wallet_id, amount, operation_type)
        @credit_wallet_id = credit_wallet_id
        @debit_wallet_id = debit_wallet_id
        @operation_type = operation_type
        @amount = amount
    end

    def process_transaction
        @credit_wallet = Wallet.find(@credit_wallet_id)
        @debit_wallet = Wallet.find(@debit_wallet_id)

        ActiveRecord::Base.transaction do
            if @operation_type == 'TOP-UP'
                transaction = TopUpTransaction.new()
            elsif @operation_type == 'TRANSFER'
                transaction = TransferTransaction.new()
            end

            transaction.create_transaction(@credit_wallet, @debit_wallet, @operation_type, @amount)
            if transaction.errors.any?
                return { success: false, error: "Transaction failed" }
            else
                { success: true }
            end
        end
    rescue ActiveRecord::RecordNotFound => e
        { success: false, error: ActiveRecord::RecordNotFound }
    rescue => e
        { success: false, error: "#{e.message}" }
    end
end