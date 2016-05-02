Rails.application.routes.draw do
  devise_for :users
  #Home page application
  root "home#index"
  #Back
  resources :shows, path: "admin/shows"
  #Front
  get '/series', to: 'shows#index'

end
