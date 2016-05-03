Rails.application.routes.draw do
  resources :episodes
  resources :episodes
  resources :seasons
  devise_for :users
  #Home page application
  root "home#index"
  resources :shows, path: "/series"

end
