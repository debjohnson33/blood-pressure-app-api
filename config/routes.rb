Rails.application.routes.draw do
  namespace :api do
  	resources :users do
  		resources :measurements
  		resources :goals
  	end
  end
end
