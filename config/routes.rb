Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      post 'client_authentication/authenticate', to: 'client_authentication#authenticate'
      resources :protected_resource, only: [:create]

      namespace :contracts_catalog do
        resources :tenants
        resources :products
        resources :pricings
        resources :contracts
      end
    end
  end
end
