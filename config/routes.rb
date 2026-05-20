Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  post "/login", to: "authentication#login"
  resources :users, only: [ :index, :show, :create, :update, :destroy ] do
    get :me, on: :collection
    patch "me", to: "users#update_me", on: :collection
    patch "me/password", to: "users#update_password", on: :collection
  end
  resources :body_measurements, only: [ :index, :show, :create, :update, :destroy ] do
    get "compare", to: "body_measurements#compare", on: :collection
  end
  resources :training_check_ins, only: [ :index ] do
    get "today", to: "training_check_ins#today", on: :collection
    post "today", to: "training_check_ins#upsert_today", on: :collection
    put "today", to: "training_check_ins#upsert_today", on: :collection
    patch "today", to: "training_check_ins#upsert_today", on: :collection
  end
  resources :competition_groups, only: [ :index, :show, :create ] do
    post "invitations", to: "competition_groups#invite", on: :member
  end
  resources :group_invitations, only: [ :index ] do
    post "accept", to: "group_invitations#accept", on: :member
    post "decline", to: "group_invitations#decline", on: :member
  end
end
