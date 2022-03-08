Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do

      scope '/lots' do
        get '/' => 'lots#index'
        get '/show' => 'lots#show'
        post '/create' => 'lots#create'
        put '/update' => 'lots#update'
        delete '/destroy' => 'lots#destroy'
      end 

      scope '/inventories' do
        get '/' => 'inventories#index'
        get '/show' => 'inventories#show'
        post '/create' => 'inventories#create'
        put '/update' => 'inventories#update'
        delete '/destroy' => 'inventories#destroy'
      end 

      scope '/inputs' do
        get '/' => 'inputs#index'
        get '/show' => 'inputs#show'
        post '/create' => 'inputs#create'
        put '/update' => 'inputs#update'
        delete '/destroy' => 'inputs#destroy'
      end 

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
