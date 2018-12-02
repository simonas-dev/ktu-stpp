class AuthController < ApiController
  
  def register
    if Admin.find_by(email: req_params[:email])
      render plain: "This Email is Taken!", status: :forbidden
      return
    end

    @user = Admin.create(req_params)
    @user.save!
    access_token = Doorkeeper::AccessToken.create!(
      resource_owner_id: @user.id,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: ''
    )
    render json: Doorkeeper::OAuth::TokenResponse.new(access_token).body
    
    rescue => exception
      render json: exception.to_s, status: :internal_server_error
  end

  private 

  def req_params
    params.permit(:email, :password, :password_confirmation)
  end
end