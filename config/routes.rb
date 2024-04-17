Rails.application.routes.draw do


  scope "api/v1" do
     resources :customers, only: [:create]


    post '/session/login', to: 'session#login'
    post '/session/logout', to: 'session#logout'
  end

end
