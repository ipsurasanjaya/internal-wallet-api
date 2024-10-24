class EntitiesController < ApplicationController
    include JsonHelper

    before_action :authorize_request
    
    def show
        entity = current_entity
        entity_data = entity.as_json(except: [:created_at, :updated_at, :password_digest])
        wallet = entity.wallet
        balance = Transaction.get_balance(wallet)

        json_response(message: "OK", data: {entity: entity_data, wallet: {id: wallet.id, balance: balance}}, status: 200)
    rescue ActiveRecord::RecordNotFound
        json_response(
          message: "data not found", 
          data: nil, 
          status: 404
        )
    rescue => e
        json_response(
          message: "an unexpected error occurred: #{e.message}", 
          data: nil, 
          status: 500
        )
    end
end
