module BaseApi
  module Organizations 
    def self.create_organization(params) 
      organization = Organization.new(params[:organization])
      errors = []
      if organization.save
        # Create the initial user_admin for the organization
        user = organization.users.new(params[:user])
        user.roles << Role.find_or_create_by(slug: 'user_admin')
        if user.save
          payload = {organization: organization, user: user}
          return ServiceContract.success(payload)
        else
          # render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          errors << ServiceContract.error(errors: user.errors.full_messages)
        end
      else
        errors << ServiceContract.error(errors: organization.errors.full_messages)
      end
      errors
    end
  end
end