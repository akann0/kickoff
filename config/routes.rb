Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"

  # get "/articles", to: "articles#index"
  # get "/articles/:id", to: "articles#show"
  resources :articles do
    resources :comments
  end

  resources :teams do
    resources :players
  end

  resources :players do
    resources :gamelogs
  end

  resources :irlleagues

  resources :irlgames do
    resources :gamelogs
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
