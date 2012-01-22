Tumblrbot::Application.routes.draw do
  root to: "home#index"
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
end
