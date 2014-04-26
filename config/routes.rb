Bizusafo::Application.routes.draw do

  resources :stories, only: [:new, :create]

  root "home#index"
end
