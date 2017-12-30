Rails.application.routes.draw do
  
  post 'user_token' => 'user_token#create'
	root to: "welcome#home"
  namespace :api do
  	resources :users do
  		resources :measurements
  		resources :goals
  	end
  end
end
