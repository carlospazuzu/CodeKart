Rails.application.routes.draw do
  resources :racers, only: %i[index create show update destroy]
  resources :races, only: %i[index create show destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
