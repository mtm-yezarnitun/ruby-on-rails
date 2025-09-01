Rails.application.routes.draw do
  get 'users/show'
  get 'uusers/shwe'
devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  resources :posts
  # get 'home/index'
  root 'posts#index'

  resources :users, only: [:show]

  get 'myposts', as: 'posts/myposts', to: 'posts#myposts'
  get "up" => "rails/health#show", as: :rails_health_check
end
