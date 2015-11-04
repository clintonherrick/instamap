Rails.application.routes.draw do
  root 'home#index'

  get '/location_recent_media' => 'home#location_recent_media'
  get '/media_search' => 'home#media_search'
  get '/location_search' => 'home#location_search'
  get '/tags' => 'home#tags'
end
