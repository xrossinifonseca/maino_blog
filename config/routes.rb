Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'


  scope "api/v1" do
     resources :customers, only: [:create]
     resources :posts, only: [:create]


    post '/session/login', to: 'session#login'
    post '/session/logout', to: 'session#logout'

    patch '/password/update', to: 'customers#update_password'
    post '/password/reset', to: 'password_resets#create'
    patch '/password/reset/edit', to: 'password_resets#update'







  end


end
