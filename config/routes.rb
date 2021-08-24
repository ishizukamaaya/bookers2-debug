Rails.application.routes.draw do

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'relationships/following' => 'relationships#following'
    get 'relationships/follower' => 'relationships#follower'
  end
  # post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  # post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す



  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

end