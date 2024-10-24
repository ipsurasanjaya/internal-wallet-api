class SessionsController < ApplicationController
    def create
        email = params[:email]
        name = params[:name]
        password = params[:password]

        entity = Entity.new()
        result = entity.authenticate(name, email, password)
        if result[:success]
          token = TokenHelper.encode(entity_id: result[:entity].id)
          render json: { token: token, exp: 24.hours.from_now }, status: :ok
        else
          render json: { error: "unauthorized: #{result[:error]}"}, status: :unauthorized
        end
      end
end
