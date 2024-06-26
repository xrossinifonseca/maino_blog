Rails.application.routes.draw do

  scope "api/v1" do
     resources :customers, only: [:create]
     resources :posts, only: [:create,:index]



    post '/session/login', to: 'session#login'
    post '/session/logout', to: 'session#logout'

    patch '/password/update', to: 'customers#update_password'
    post '/password/reset', to: 'password_resets#create'
    get "profile", to: 'customers#profile'

    get "my-posts", to: 'posts#customer_posts'
    delete 'posts/:id', to: "posts#destroy"
    get 'posts/:id',to: "posts#show"
    put 'posts/:id', to: "posts#update"
    post "post/upload", to: "posts#upload_content"


    patch "/customer/update", to: "customers#update"


    post 'comments/:id', to: 'comments#create'

    match '*unmatched_route', to: 'application#route_not_found', via: :all
  end

  patch '/password/reset/edit', to: 'password_resets#update'

end
