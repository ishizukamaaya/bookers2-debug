Rails.application.routes.draw do

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do

    resource :relationships, only: [:create, :destroy]
    get 'follow' => 'relationships#follow', as: 'follow'
    get 'follower' => 'relationships#follower', as: 'follower'
  end


  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

end