# require 'jwt'

module BaseApi
  module Auth
    include JWT

    def self.login(params)
      user = User.find_by(email: params[:email])
      # debugger
      if user&.authenticate(params[:password])
        payload = {user_id: user.id, exp: 1.week.from_now.to_i}
        token = JWT.encode(payload, Rails.application.credentials.secret_key_base)
        client_payload = {token: token}
        ServiceContract.success(success?: true, payload: client_payload, errors: nil)

      else
        ServiceContract.error(success?: false, payload: nil, errors: 'Invalid email or password')
      end
    end
  end
end
