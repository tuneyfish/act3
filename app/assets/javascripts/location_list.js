// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var centerLatitude = 42.122964;
var centerLongitude = 83.321584;

var startZoom = 15;
var map;

function init() 
{
    if ( GBrowserIsCompatible() ) 
    {
        map = new GMap2( document.getElementById( "map" ) );
        map.addControl( new GSmallMapControl() );
        map.addControl( new GMapTypeControl() );
        if ( shops.length > 0 )
        {
          map.setCenter( new GLatLng( shops[0].lat, shops[0].lng), startZoom );
        }
        else if ( centerLat != null && centerLng != null )
        {
          map.setCenter( new GLatLng( centerLat, centerLng ), startZoom - 2 );
        } 
        else
        {
          map.setCenter( new GLatLng( centerLatitude, centerLongitude ), startZoom - 4 );
        }
        
          
  
//        addMarker( studio.latitude, studio.longitude, studio.name );  
        for( idx = 0; idx < shops.length; idx++ )
        {
            addShopMarker( shops[idx] );
        }       
    }
}

function addShopMarker( shop )
{
    var shopLocation = new GLatLng( shop.lat, shop.lng )
    var marker = new GMarker( shopLocation );
    
    var stg = "<html><b>" + shop.name + "</b><br/>" + 
      shop.address_1 + "<br/>" + 
      shop.city + " " + shop.state + " " + shop.postal_code + "<br/><br/>" + 
      shop.phone_number + "<br/>" + 
      "</html>"
    
    GEvent.addListener( marker, 'click',
        function()
        {
            marker.openInfoWindowHtml( stg );
        }
    );
    
    map.addOverlay( marker );
}

window.onload = init;
window.onunload = GUnload;
