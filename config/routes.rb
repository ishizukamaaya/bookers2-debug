Rails.application.routes.draw do

  get 'users/index'
  get 'users/show'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'

  resources :messages, only: [:create, :show]
  # resources :rooms, only: [:create,:show]
end