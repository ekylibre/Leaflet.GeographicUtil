L = require('leaflet')
GeographicLib = require("geographiclib")

class L.GeographicUtil
  @Polygon: (points, polyline = false) -> # (Array of [lat,lng] pair)
    geod = GeographicLib.Geodesic.WGS84
    
    if points.length == 2 || polyline
      polyline = true

    poly = geod.Polygon(polyline)
    for point in points
      poly.AddPoint point[0], point[1]

    poly = poly.Compute(false, true)

    perimeter: poly.perimeter, area: Math.abs poly.area

# Use Karney distance formula
# ([lat, lng], [lat, lng]) -> Number (in meters)
  @distance: (a, b) ->
    geod = GeographicLib.Geodesic.WGS84
    r = geod.Inverse(a[0], a[1], b[0], b[1])
    r.s12.toFixed(3)
