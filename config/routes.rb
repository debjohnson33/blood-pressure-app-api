Rails.application.routes.draw do
  
  devise_for :users
	root to: "home#index"
  namespace :api do
  	resources :users, shallow: true do
  		resources :measurements
  		resources :goals
  	end
  end
end
