# coding: utf-8
require 'rubygems'
require 'google_directions'
include GeoKit::Geocoders
def index
    coordinates =[13.0343841,  80.2502535] #you can get the coordinates for the location you want from http://stevemorse.org/jcal/latlon.php
    @map = GMap.new(“map”)
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init(coordinates,10) # here 10 referes to the zoom level for a map
    @map.overlay_init(GMarker.new(coordinates,:title => “Chennai”, :info_window => “Chennai”))
end
def location
    new_location = params[:new_location]
    dist_location = params[:dist_location]
    gg = GeoKit::Geocoders::google="ABQIAAAAU0dD2riOcNwaY-9-iOONwBTJQa0g3IQ9GZqIMmInSLzwtGDKaBQRX-rafZp2JgGyOXXv8Vqj2fE-ZA"
    gg_locate = GeoKit::Geocoders::MultiGeocoder.geocode(new_location)
    coordinates = [gg_locate.lat, gg_locate.lng]
    @map = GMap.new(“map”)
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init(coordinates,10)
    @map.overlay_init(GMarker.new(coordinates, :title => new_location, :info_window => new_location))
    if params[:dist_location] && !params[:dist_location].blank?
        gg_locate1 = GeoKit::Geocoders::MultiGeocoder.geocode(dist_location)
        coordinates1 = [gg_locate1.lat, gg_locate1.lng]
        @dist=gg_locate.distance_to(gg_locate1)
        @dist=@dist*1.6
        @directions = GoogleDirections.new(new_location, dist_location)
        @map.overlay_init(GMarker.new(coordinates1, :title => "#{dist_location} – #{@dist.round(2)} Kms away from #{new_location}", :info_window => "#{dist_location} – #{@dist.round(2)} Kms <br/> away from #{new_location}"))
        require 'net/http'
        require 'rexml/document'
        url = "#{@directions.xml_call}"
        # get the XML data as a string
        xml_data = Net::HTTP.get_response(URI.parse(url)).body
        # extract event information
        doc = REXML::Document.new(xml_data)
        duration = []
        way = []
        kms=[]
        full_text=[]
        doc.elements.each(‘DirectionsResponse/route/leg/step/html_instructions’) do |a|
            way<<a.text
        end
        doc.elements.each(‘DirectionsResponse/route/leg/step/distance/text’) do |a|
            kms<<a.text
        end
        doc.elements.each(‘DirectionsResponse/route/leg/step/duration/text’) do |a|
            duration<<a.text
        end
        way.each_with_index do|text, index|
            full_text<<”#{kms[index]}(#{duration[index]})—>#{way[index]}<br/>”
        end
        @full_text=full_text
    end
    render :action => “index”
end