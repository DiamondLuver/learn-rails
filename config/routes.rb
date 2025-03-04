Rails.application.routes.draw do
  get "charges/new"
  get "charges/create"
  
  get "pages/home"
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update, :destroy] 
  get "profile" => "users#profile_show", as: :profile_show
  delete "users/:id" => "users#destroy", as: :destroy_user
  # resources :payments
  get '/create-checkout-session' => "payments#create_checkout_session"
    
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "products#index"
  resources :products
  resources :vendors
  post "carts/:product_id" => "carts#create", as: :add_to_cart
  get "carts" => "carts#show", as: :cart
  delete "carts/:product_id" => "carts#remove_from_cart", as: :remove_from_cart
  delete "products/:id" => "products#destroy", as: :destroy_product
  delete "vendors/:id" => "vendors#destroy", as: :destroy_vendor
  get "users", to: "users#index", as: "users_index"
  
  get "payment/checkout" => "payments#checkout", as: :payment_checkout

  get "carts/:id" => "carts#checkout", as: :cart_checkout

  resources :charges, only: [:new, :create]
  get 'thanks', to: 'charges#thanks', as: 'thanks'
  
  
end
