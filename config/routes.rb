Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create] do
    resources :transactions, only: [:index, :create]
    resources :rewards, only: [:index, :create]
    resources :reward_redemptions, only: [:index, :create]
    get :points_summary, on: :member
  end
end
