Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #get 'home/top'
  #get 'hello_page/hello'
  root 'application#hello'
  get "/tweets/search" => 'tweets#search'
  post "/tweets/search", to:'tweets#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
