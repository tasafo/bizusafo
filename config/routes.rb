Bizusafo::Application.routes.draw do
  devise_for :users

  resources :stories do
    put :positive
    put :negative
  end

  resources :comments

  root "home#index"
end
