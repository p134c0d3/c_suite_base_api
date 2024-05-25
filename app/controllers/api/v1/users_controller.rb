module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request, only: %i[login create]

      def me
        render_success(payload: UserBlueprint.render_as_hash(@current_user), status: 200)
      end

      def create
        result = BaseApi::Users.create_user(user_params)

        
          render_error(errors: 'There was a problem creating the user', status: 400) and return unless result.success?

        payload = {
          user: UserBlueprint.render_as_hash(result.payload, view: :normal)
        }
        render_success(payload: payload, status: 201)
      end

      def login
        result = BaseApi::Auth.login(user_params)
        render_error(errors: result.errors.full_messages, status: 400) and return unless result.success?

        render_success(payload: result.payload, status: 200)
      end

      private

      def jwt_encode(payload, exp = 48.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, Rails.application.credentials.secret_key_base)
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
  end
end
