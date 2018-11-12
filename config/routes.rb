Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
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
