module Api
  module V1
    class OrganizationsController < ApplicationController
      before_action :authenticate_request, except: [:create]

      def create
        # Makes sure the params are being sent to the service correctly. 
        formatted_params = {organization: organization_params, user: user_params}
        result = BaseApi::Organizations.create_organization(formatted_params)

        render_error(errors: 'There was a problem creating the user and organization', status: 400) and return unless result.success?

        render_success(payload: result.payload)
      end

      private 

      def organization_params
        params.require(:organization).permit(:name)
      end

      def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
      end
    end
  end
end