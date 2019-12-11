$(document).ready(function(){

function setUpClickListener(map) {
  map.addEventListener('tap', function (evt) {
    var coord = map.screenToGeo(evt.currentPointer.viewportX,
            evt.currentPointer.viewportY);
    var marker = new H.map.Marker(new H.geo.Point(coord.lat, coord.lng));
    console.log(coord.lat, coord.lng)
    map.removeObjects(map.getObjects());
    map.addObject(marker);
  });
}

// Initialize the platform object:
var platform = new H.service.Platform({
'apikey': 'YGUmMw55U3s1mArR6tdoAcyWVizGAIAub2kxDtp_Xic'
});

// Obtain the default map types from the platform object
var maptypes = platform.createDefaultLayers();

// Instantiate (and display) a map object:
var map = new H.Map(
document.getElementById('mapContainer'),
maptypes.vector.normal.map,
{
  zoom: 10,
  center: { lng: 13.4, lat: 52.51 }
});

window.addEventListener('resize', () => map.getViewPort().resize());

var behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

var ui = H.ui.UI.createDefault(map, maptypes);

setUpClickListener(map)

});
