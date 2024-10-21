module JsonHelper
    def json_response(message:, data:, status:)
        render json: { message: message, data: data, status_code: status }, status: status
    end
end
