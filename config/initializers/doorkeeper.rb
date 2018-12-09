# Doorkeeper Config
Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  resource_owner_from_credentials do |_routes|
    Admin.authenticate(params[:email], params[:password])
  end

  grant_flows %w[password]

  skip_authorization do
    true
  end

  access_token_generator '::Doorkeeper::JWT'
end

Doorkeeper::JWT.configure do
  # Set the payload for the JWT token. This should contain unique information
  # about the user. Defaults to a randomly generated token in a hash:
  #     { token: "RANDOM-TOKEN" }
  token_payload do |opts|
    user = Admin.find(opts[:resource_owner_id])

    {
      iss: 'ktu-stpp 2018 💰',
      iat: Time.current.utc.to_i,

      # @see JWT reserved claims - https://tools.ietf.org/html/draft-jones-json-web-token-07#page-7
      jti: SecureRandom.uuid,

      user: {
        id: user.id,
        email: user.email
      }
    }
  end

  # Optionally set additional headers for the JWT. See
  # https://tools.ietf.org/html/rfc7515#section-4.1
  # token_headers do |opts|
  #   { kid: opts[:application][:uid] }
  # end

  # Use the application secret specified in the access grant token. Defaults to
  # `false`. If you specify `use_application_secret true`, both `secret_key` and
  # `secret_key_path` will be ignored.
  use_application_secret false

  # Set the encryption secret. This would be shared with any other applications
  # that should be able to read the payload of the token. Defaults to "secret".
  secret_key 'secret_key'

  # Specify encryption type (https://github.com/progrium/ruby-jwt). Defaults to
  # `nil`.
  encryption_method :hs512
end

# Custom Error Message on Invalid Email or Pass
module CustomTokenErrorResponse
  def body
    'Incorrect Login Credentials!'
  end
end

Doorkeeper::OAuth::ErrorResponse.send :prepend, CustomTokenErrorResponse
