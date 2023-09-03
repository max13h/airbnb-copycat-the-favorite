Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lenses
  resources :bookings, only: [:index, :destroy, :update]
  get "dashboard", to: "pages#dashboard"
  get "users/:id/lenses", to: "users#lenses", as: "user_lenses"
end
