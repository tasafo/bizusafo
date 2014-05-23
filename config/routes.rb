Bizusafo::Application.routes.draw do

  devise_for :users

  resources :users, only: [:none] do
    resources :stories, only: [:new, :create]
  end

  resources :stories, only: [:none] do
    put :positive
    put :negative
  end

  root "home#index"
end
