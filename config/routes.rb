Rails.application.routes.draw do
  get 'users/show'
devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  namespace :admin do 
    resources :users
  end
  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end

  resources :posts do
   resources :comments, only: [:create, :destroy]
  end
  # get 'home/index'
  root 'posts#index'

  resources :users, only: [:show]

  get 'myposts', as: 'posts/myposts', to: 'posts#myposts'
  get "up" => "rails/health#show", as: :rails_health_check
end
