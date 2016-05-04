Rails.application.routes.draw do
  devise_for :users
  #Home page application
  root "home#index"
  resources :shows, path: "/series"

end