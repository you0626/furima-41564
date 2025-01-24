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
  get 'users/about', to: 'users#about'
  get 'users/privacy_policy', to: 'users#privacy_policy'
  get 'users/service', to: 'users#service'
  get 'users/point', to: 'users#point'
  get 'users/guide', to: 'users#guide'
  get 'users/logo_guidelines', to: 'users#logo_guidelines'
  get 'users/notifications', to: 'users#notifications'

end
