Rails.application.routes.draw do
  root 'home#index'
  
  get '/results' => 'home#results'
end
