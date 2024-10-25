class TransactionsController < ApplicationController
    include JsonHelper

    before_action :authorize_request

    def create 
        credit_wallet_id = params[:credit_wallet]
        debit_wallet_id = params[:debit_wallet]
        operation_type = params[:operation_type]
        amount = params[:amount].to_f

        entity = current_entity

        if credit_wallet_id == debit_wallet_id && operation_type == "TRANSFER"
            json_response(message: "cannot create transaction using same wallet", data: nil, status: 400)
        end

        service = WalletTransactionService.new(credit_wallet_id, debit_wallet_id, amount, operation_type, entity)
        result = service.process_transaction

        if result[:success]
            json_response(message: "OK", data: result[:data], status: 200)
        elsif result[:error] == ActiveRecord::RecordNotFound
            json_response(message: "data not found", data: result[:data], status: 404)
        else
            json_response(message: "internal server error: #{result[:error]}", data: result[:data], status: 500)
        end
    end
end
