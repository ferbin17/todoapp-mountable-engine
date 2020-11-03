Todoapp::Engine.routes.draw do
  post 'todos/rearrange'
  resources :users do
    collection do
      get :login
      post :login
      get :sign_up
      post :sign_up
      delete :logout
      get :dashboard
      get :resend_otp
      get :forgot_password
      post :forgot_password
      patch :forgot_password
    end
  end
  resources :todos do
    resources :comments
  end
  resources :shares
  
  get '*unmatched_route', to: 'application#raise_not_found'
  root 'todos#index'
end
