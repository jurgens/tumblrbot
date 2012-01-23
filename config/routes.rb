Tumblrbot::Application.routes.draw do
  root to: "home#index"
  resources :authentications, only: [:index, :create, :destroy]

  resource :settings, only: [] do
    collection do
      post :status
    end
  end

  post 'upload' => "home#upload"
  match '/auth/:provider/callback' => 'authentications#create'
end
