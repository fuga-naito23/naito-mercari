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

  resources :category,only:[:index, :show]

  resources :products, only: [:new, :create, :show, :edit, :update, :destroy] do
  collection do
    get "search"
  end
      resources :payments, only: [:new, :create]
  end

  resources :cards, only: [:new, :create]

end
