module BaseApi
  module Organizations 

    # this is for a new user and new org. Essentially the signup for new user and org.
    def self.create_organization(params) 
      # Org gets started
      organization = Organization.new(params[:organization])
      # Errors array is because we are dealing with two entities here 
      errors = []
      if organization.save
        # Create the initial user_admin for the organization
        user = organization.users.new(params[:user])
        user.roles << Role.find_or_create_by(slug: 'org_admin')
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