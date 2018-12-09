Rails.application.routes.draw do
  # Home
  root to: "landing#index"

  # Oauth2
  use_doorkeeper do
    skip_controllers :authorizations, :applications,
      :authorized_applications
  end  

  # RESTful API 
  scope '/api' do
    scope '/v1' do
      scope '/register' do
        post '/' => 'auth#register'
      end
      scope '/author' do
        get '/' => 'authors#index'
        post '/' => 'authors#create'
        scope '/:id' do
          get '/' => 'authors#show'
          put '/' => 'authors#update'
          delete '/' => 'authors#destroy'
        end
      end
      scope '/book' do
        get '/' => 'books#index'
        post '/' => 'books#create'
        scope '/:id' do
          get '/' => 'books#show'
          put '/' => 'books#update'
          delete '/' => 'books#destroy'
          get '/authors' => 'books#authors'
        end
      end
    end
  end
end
