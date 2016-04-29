Rails.application.routes.draw do
  resources :shows
  root "home#index"
end
