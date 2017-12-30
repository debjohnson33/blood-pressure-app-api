Rails.application.routes.draw do
  
  devise_for :users
	root to: "welcome#home"
  namespace :api do
  	resources :users do
  		resources :measurements
  		resources :goals
  	end
  end
end
