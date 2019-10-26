Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
   }

  root to: "products#index"

  resources :users, only: [:show] do
    member do
      get "likes", "listings", "in_progress", "completed", "purchase", "purchased"
    end
  end

  resources :products, only: [:new, :create, :show] do
    # member do
      resources :payments, only: [:new, :create]
      # post "purchase"
    # end
  end

  resources :cards, only: [:new, :create]

end
