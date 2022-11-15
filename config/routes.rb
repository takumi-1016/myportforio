Rails.application.routes.draw do
  get 'home/top'
  root to: 'home#top'
end
