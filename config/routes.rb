Rails.application.routes.draw do
  resources :players do
    resources :matches
  end
  # get /players?nationality , to: 'players#show'


  resources :matches

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
