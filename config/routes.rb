Tumblrbot::Application.routes.draw do
  root to: "home#index"
  resources :authentications, only: [:index, :create, :destroy]
  post 'upload' => "home#upload"
  match '/auth/:provider/callback' => 'authentications#create'
end
