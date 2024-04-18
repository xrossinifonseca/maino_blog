Rails.application.routes.draw do

  scope "api/v1" do
     resources :customers, only: [:create]
     resources :posts, only: [:create,:index]



    post '/session/login', to: 'session#login'
    post '/session/logout', to: 'session#logout'

    patch '/password/update', to: 'customers#update_password'
    post '/password/reset', to: 'password_resets#create'
    patch '/password/reset/edit', to: 'password_resets#update'

    delete 'posts/:id', to: "posts#destroy"
    put 'posts/:id', to: "posts#update"


    post 'comments/:id', to: 'comments#create'



  end


end
