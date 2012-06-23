GitPlugged::Application.routes.draw do
  resources :repos

  resources :votes

  get "auth/twitter/callback", to: "sessions#create"
  get "logout", to: "sessions#destroy"
end
