Rails.application.routes.draw do
  resources :users, only: [:create] do
    resources :transactions, only: [:create]
    resources :rewards, only: [:index]
  end
end
