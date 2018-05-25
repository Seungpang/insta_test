Rails.application.routes.draw do
  get 'hashtags/index'

  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  
  get 'hashtags/:hashtags_id' => 'hashtags#index'

  get 'users/posts/guest_view' => 'posts#guest_view'
  
  get 'users/posts' => 'posts#index'
end
