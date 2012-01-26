Tumblrbot::Application.routes.draw do
  root to: "home#index"
  resources :authentications, only: [:index, :create, :destroy]

  resource :settings, only: [] do
    collection do
      post :status
    end
  end

  resources :jobs, only: [] do
    post :clear, on: :collection
  end

  post 'upload' => "home#upload"
  match '/auth/:provider/callback' => 'authentications#create'
end
