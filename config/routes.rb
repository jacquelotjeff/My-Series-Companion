Rails.application.routes.draw do
  # resources :episodes
  get '/episodes/vu/:id_show/:id_episode', to: 'episodes#viewed', as: 'viewed'
  get '/episodes/non-vu/:id_show/:id_episode', to: 'episodes#unviewed', as: 'unviewed'
  resources :shows, path: "/series"
  get '/series/synchroniser/:id', to: 'shows#synch', as: 'synch'
  devise_for :users

  # Default route
  root to: "shows#index"
end