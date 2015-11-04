class HomeController < ApplicationController

  def index
    @instagram = Instagram.user_recent_media("10856109", {:count => 1})
  end

  def location_recent_media
    client = Instagram.client()
    html = "<h1>Media from the Instagram Office</h1>"
    for media_item in client.location_recent_media(514276)
      html << "<img src='#{media_item.images.thumbnail.url}'>"
    end
    html
  end

  def media_search
    client = Instagram.client(:access_token => config[:access_token])
    # html = "<h1>Get a list of media close to a given latitude and longitude</h1>"
    # for media_item in client.media_search("37.7808851","-122.3948632")
    #   html << "<img src='#{media_item.images.thumbnail.url}'>"
    # end
    # html
    @results = client.media_search("37.7808851","-122.3948632")[1,5]
  end

  def location_search
    client = Instagram.client(:access_token => config[:access_token])
    html = "<h1>Search for a location by lat/lng with a radius of 5000m</h1>"
    for location in client.location_search("48.858844","2.294351","5000")
      html << "<li> #{location.name} <a href='https://www.google.com/maps/preview/@#{location.latitude},#{location.longitude},19z'>Map</a></li>"
    end
    html
  end

  def tags
    client = Instagram.client(:access_token => config[:access_token])
    html = "<h1>Search for tags, get tag info and get media by tag</h1>"
    tags = client.tag_search('cat')
    html << "<h2>Tag Name = #{tags[0].name}. Media Count =  #{tags[0].media_count}. </h2><br/><br/>"
    for media_item in client.tag_recent_media(tags[0].name)
      html << "<img src='#{media_item.images.thumbnail.url}'>"
    end
    html
  end
end
