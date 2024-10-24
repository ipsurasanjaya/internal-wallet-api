class ApplicationController < ActionController::API
    def authorize_request
      token = request.headers['Authorization'].split(' ').last if request.headers['Authorization']
      decoded = TokenHelper.decode(token)
  
      if decoded
        @current_entity = Entity.find_by(id: decoded[:entity_id])
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
    
    def current_entity
      @current_entity
    end
end
