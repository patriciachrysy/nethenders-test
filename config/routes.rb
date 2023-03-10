Rails.application.routes.draw do
  root "home#index"
  get "/", to: "home#index"
  get "/results", to: "home#results", as: "results"
  post "/evaluate", to: "home#evaluate", as: "evaluate"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
