Rails.application.routes.draw do
  resources :events, only: [:index]

  root to: "main#show"
end
