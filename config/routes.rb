Rails.application.routes.draw do


  scope "api/v1" do
     resources :customers, only: [:create]
  end

end
