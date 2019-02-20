Rails.application.routes.draw do
  apipie

  namespace :api do
    # Api definition
    namespace :v1, defaults: { format: :json } do
      resources :customers, only: [:index, :create, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end