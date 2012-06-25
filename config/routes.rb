GitPlugged::Application.routes.draw do
  resources :repos, only: [:index, :create] do
    resources :votes, only: [:create]
  end

  get "auth/twitter/callback", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  root to: "repos#index"
end
