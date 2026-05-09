Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  post "/login", to: "authentication#login"  
  resources :users, only: [:index, :show, :create, :update, :destroy] do
    get :me, on: :collection
    patch "me", to: "users#update_me", on: :collection
    patch "me/password", to: "users#update_password", on: :collection
  end
  resources :body_measurements, only: [:index, :show, :create, :update, :destroy]
end
