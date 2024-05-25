class Api::V1::ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
  
    before_action :authenticate_request

    def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          decoded = JWT.decode(header, Rails.application.credentials.secret_key_base).first
          @current_user = User.find(decoded['user_id'])
        rescue JWT::ExpiredSignature
          render json: { error: 'Token has expired' }, status: :unauthorized
        rescue JWT::DecodeError
          render json: { errors: 'Unauthorized' }, status: :unauthorized
        end
      end

  
    def render_error(errors:, status: :internal_server_error)
      render json: {
        success: false,
        errors: errors,
        status: status
      }, status: status
    end
  
    def render_success(payload:, status: :ok)
      render json: {
        success: true,
        payload: payload
      }, status: status
    end
  end
