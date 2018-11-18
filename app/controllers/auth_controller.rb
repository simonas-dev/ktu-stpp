class AuthController < ApiController
    def register
        @user = Admin.create(req_params)
        @user.save!
        render json: @user.save
    end

    private 

    def req_params
        params.permit(:email, :password, :password_confirmation)
    end
end