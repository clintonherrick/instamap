class HomeController < ApplicationController

  def index
    @instagram = Instagram.user_recent_media("10856109", {:count => 1})
  end

  # def location_recent_media
  #   client = Instagram.client()
  #   html = "<h1>Media from the Instagram Office</h1>"
  #   for media_item in client.location_recent_media(514276)
  #     html << "<img src='#{media_item.images.thumbnail.url}'>"
  #   end
  #   html
  # end
  #
  # def media_search
  #   client = Instagram.client(:access_token => config[:access_token])
  #   @results = client.media_search("37.7808851","-122.3948632")[1,10]
  # end
  #
  # def location_search
  #   client = Instagram.client(:access_token => config[:access_token])
  #   html = "<h1>Search for a location by lat/lng with a radius of 5000m</h1>"
  #   for location in client.location_search("48.858844","2.294351","5000")
  #     html << "<li> #{location.name} <a href='https://www.google.com/maps/preview/@#{location.latitude},#{location.longitude},19z'>Map</a></li>"
  #   end
  #   html
  # end
  #
  # def tags
  #   client = Instagram.client()
  #   @tag = params[:tag]
  #   @results = client.tag_recent_media(@tag)
  # end

  def results
    client = Instagram.client()
    @hashtag = params[:hashtag].empty? ? nil : params[:hashtag]
    @location = params[:location].empty? ? nil : params[:location]

    if @location
      @geocoded_location = Location.create(:address => @location)
      @results = client.media_search(@geocoded_location.latitude,
                                     @geocoded_location.longitude)
      # if @hashtag
      #   @results
      # end
    elsif @hashtag
      @results = client.tag_recent_media(@hashtag)
    end

    @results
  end
end
