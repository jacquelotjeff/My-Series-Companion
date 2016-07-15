Rails.application.routes.draw do
  # resources :episodes
  get '/episodes/viewed/:id_show/:id_episode', to: 'episodes#viewed', as: 'viewed'
  resources :seasons
  devise_for :users
  #Home page application

  #Ancienne route pour la racine de l'appli (ancienne page d'accueil mais vide pour le moment)
  #root "home#index"

  #Nouvelle route pour la racine, qui fait directement appel au controller shows
  root to: "shows#index"
  
  resources :shows, path: "/series"
  get '/series/synchroniser/:id', to: 'shows#synch', as: 'synch'
end