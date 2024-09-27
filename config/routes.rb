Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resources :items do
    collection do
      get 'search'
    end
    resources :orders, only: [:index, :create]do
      resources :addresses, only: [:create]
    end
  end
end
