Rails.application.routes.draw do
  #Home page application
  root "home#index"
  #Back
  resources :shows, path: "admin/shows"
  #Front
  get '/shows', to: 'home#shows'

end
