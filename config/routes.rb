Rails.application.routes.draw do
  root 'pages#homepage'

  resources :chef_recipes
end
