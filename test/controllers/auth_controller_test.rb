require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test 'registration' do
    post :register, params: {
      email: 'test@acc.lt',
      password: 'password',
      password_confirmation: 'password'
    }
    assert_response :success
  end

  # Login happens via internal Doorkeeper controller.
end
