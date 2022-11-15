Rails.application.routes.draw do
  devise_for :users
  get 'home/top'
  root to: 'home#top'
end
