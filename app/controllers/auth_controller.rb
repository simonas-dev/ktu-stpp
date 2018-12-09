# Controler for handling user authentication.
class AuthController < ApiController
  def register
    if email_taken?
      render plain: 'This Email is Taken!', status: :forbidden
      return
    end
    user = Admin.create(req_params)
    user.save!
    access_token = create_access_token(user.id)
    render json: Doorkeeper::OAuth::TokenResponse.new(access_token).body
  rescue StandardError => exception
    render json: exception.to_s, status: :internal_server_error
  end

  private

  def req_params
    params.permit(:email, :password, :password_confirmation)
  end

  def email_taken?
    Admin.find_by(email: req_params[:email]) != nil
  end

  def create_access_token(user_id)
    Doorkeeper::AccessToken.create!(
      resource_owner_id: user_id,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: ''
    )
  end
end
