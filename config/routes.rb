Rails.application.routes.draw do
  
	root to: "welcome#home"
  namespace :api do
	post 'user_token' => 'user_token#create'
  	resources :users do
  		resources :measurements
  		resources :goals
  	end
  end
end
