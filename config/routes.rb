Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  post "/login", to: "authentication#login"  
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :body_measurements, only: [:index, :show, :create, :update, :destroy]
end
