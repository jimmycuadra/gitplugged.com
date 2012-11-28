GitPlugged::Application.routes.draw do
  scope "api" do
    resources :repos, only: [:index, :create] do
      resources :votes, only: [:create]
    end

    resources :winners, only: :index
  end

  get "auth/twitter/callback", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  root to: "web#index"

  match "(*path)" => "web#index"
end
