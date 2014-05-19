Bizusafo::Application.routes.draw do

  devise_for :users

  resources :users, only: [:none] do
    resources :stories, only: [:new, :create]
  end

  root "home#index"
end
