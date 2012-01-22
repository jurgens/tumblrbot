Tumblrbot::Application.routes.draw do
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
end
