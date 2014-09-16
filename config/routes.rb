Bizusafo::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :api do
    namespace :v1 do
      resource :token, only: :create
      resources :stories, only: :create
    end
  end

  resource :profile, only: :show

  resource :notification_setting, only: :update

  resources :stories do
    put :positive
    put :negative
  end

  resources :comments

  root "home#index"
end