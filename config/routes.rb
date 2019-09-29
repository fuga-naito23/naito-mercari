Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :users, only: [:show] do
    member do
      get "likes", "listings", "in_progress", "completed", "purchase", "purchased"
    end
  end
  resources :products, only: [:new, :create, :show] do
    member do
      post "purchase"
    end
  end
end
