Rails.application.routes.draw do

  get 'users/index'
  get 'users/show'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'search' => "users#search"
  end

  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'

  resources :messages, only: [:create, :show]

  get 'search_book' => 'books#search_book'

  resources :groups do
    get 'join' => 'groups#join'
    get 'new/mail' => 'groups#new_mail'
    get 'send/mail' => 'groups#send_mail'
  end
end