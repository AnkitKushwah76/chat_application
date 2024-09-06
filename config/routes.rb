Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  resources :rooms do
    resources :messages
    member do
      post 'add_people'
    end
  end
  root 'rooms#index'
end