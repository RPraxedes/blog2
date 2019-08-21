Rails.application.routes.draw do
  root 'pages#homepage'

  resources :chef_recipes

  get '/signup', to: 'chef_profiles#new'
  resources :chef_profiles, except: [:new]

end
