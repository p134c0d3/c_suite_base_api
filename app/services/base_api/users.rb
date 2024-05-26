module BaseApi
  module Users 
    def self.create_user(params)
      user = User.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password],
        )

      begin
        user.save!
      rescue ActiveRecord::RecordInvalid => exception 
        return ServiceContract.error('Error saving user') unless user.valid?
      end

      ServiceContract.success(user)
    end
  end

end
