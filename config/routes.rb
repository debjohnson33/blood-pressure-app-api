Rails.application.routes.draw do
  namespace :api do
  	resources :users, shallow: true do
  		resources :measurements
  		resources :goals
  	end
  end
end
