Rails.application.routes.draw do
  resources :posts do
    resources :comments, except: :show
  end

  root to: 'posts#index'
  get "up" => "rails/health#show", as: :rails_health_check
end
