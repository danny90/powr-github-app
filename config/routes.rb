Rails.application.routes.draw do
  resources :home, only: [:index, :show]
  resources :authorization, only: [:index]
  root :to => "home#index"
end
