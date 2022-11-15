Rails.application.routes.draw do
  resources :tags do
    get 'search', to: 'post_titles#search'
  end
  resources :post_titles, only: [:show, :create, :destroy]
  resources :post_comments, only: [:create, :destroy] do
    resource :like, only: [:create, :destroy]
  end
  resources :teams do
    get '/registration' =>'teams#registration'
    patch '/teamCertification' =>'teams#teamCertification'
    get '/teamboard' =>'teams#teamboard'
  end
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, only: [:show, :edit, :update] do
    post '/withdrowTeam' => 'users#withdrowTeam'
  end
  get '/mypage' => 'users#mypage'
  get '/myteam' => 'teams#myteam'
  get '/myboard' => 'teams#myboard'
  patch '/teamIDregistration' =>'users#teamIDregistration'
  root to: "home#top"
end
