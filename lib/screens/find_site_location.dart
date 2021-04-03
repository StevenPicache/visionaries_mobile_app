import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:visionariesmobileapp/constants.dart';


class FindSiteLocation extends StatefulWidget {
  static final String routeName = '/find';

  String get title => "Vizualize";

  @override
  _FindSiteLocationState createState() => _FindSiteLocationState();
}

class _FindSiteLocationState extends State<FindSiteLocation> {

  BitmapDescriptor carIcon;
  var location = new Location();
  Map<String, double> userLocation;
  StreamSubscription _locationSubscription;
  LocationData currentLocation;
  Location _locationTracker = Location();
  Marker marker;
  Marker startingMarker;
  Marker destinationMarker;
  Marker currentPositionMarker;
  Circle circle;
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;


  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  Address destinationAddress;
  Set<Marker> markers = {};

  PolylinePoints polylinePoints; //Object for polyline points
  Map<PolylineId, Polyline> polylines =  {}; //Map storing polylines created by two points
  List<LatLng> polylineCoordinates = []; //List of coordinates to join


  Widget _textField({
    TextEditingController controller,
    String label,
    String hint,
    String initialValue,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        // initialValue: initialValue,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }



/*
  * FUNCTION : updateCurrentMarker
  *
  * DESCRIPTION : Updates the current users location marker
  *
  * PARAMETERS : LocationData newLocalData - New Location of the user
  *
  * RETURNS : NONE
  */
  void updateCurrentMarker(LocationData newLocalData) async {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {

      currentPositionMarker = Marker(
          markerId: MarkerId("currentPositionMarker"),
          position: latlng,
          icon: BitmapDescriptor.defaultMarker);
    });

    markers.add(currentPositionMarker);
  }




  /*
  * FUNCTION : updateDestinationMarker
  *
  * DESCRIPTION : Updates the destination location marker
  *
  * PARAMETERS : Address destinationAddress - Destination Of Route
  *
  * RETURNS : NONE
  */
  void updateDestinationMarker(Address destinationAddress) async {

    LatLng latlng = LatLng(destinationAddress.coordinates.latitude, destinationAddress.coordinates.longitude);
    this.setState(() {
      destinationMarker = Marker(
          markerId: MarkerId("destinationMarker"),
          position: latlng,
          icon: BitmapDescriptor.defaultMarker);
    });

    markers.add(destinationMarker);

    _drawRouteLines(currentLocation, destinationAddress);

  }



/*
  * FUNCTION : _getInitialLocation()
  *
  * DESCRIPTION : This function retrieves the initial location upon opening the map
  *
  * PARAMETERS : NONE
  *
  * RETURNS : NONE
  */
  _getInitialLocation() async {
    try {

      currentLocation = await _locationTracker.getLocation();

      updateCurrentMarker(currentLocation);

      mapController.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(currentLocation.latitude, currentLocation.longitude),
              tilt: 0,
              zoom: 18.00)));
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }


  /*
  * FUNCTION : _getCurrentLocation()
  *
  * DESCRIPTION : This function continuously updates the current users location and
  *               calls to update the current location marker
  *
  * PARAMETERS : NONE
  *
  * RETURNS : NONE
  */
  _getCurrentLocation() async {
    try {

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
            if (mapController != null) {
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  new CameraPosition(
                      bearing: 180,
                      target: LatLng(newLocalData.latitude, newLocalData.longitude),
                      tilt: 0,
                      zoom: 16.00)));

              updateCurrentMarker(newLocalData);

            }
          });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }


  /*
  * FUNCTION : _stopGettingLocation()
  *
  * DESCRIPTION : This function stop getting the continuous current location of the device
  *
  * PARAMETERS : NONE
  *
  * RETURNS : NONE
  */
  _stopGettingLocation() async {
    try {

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

    } on PlatformException catch (e) {
      if (e.code == 'No Gps Running') {
        debugPrint("Currently Not Tracking ");
      }
    }
  }




  /*
  * FUNCTION : _drawRouteLines()
  *
  * DESCRIPTION : This creates the polylines showing the route between two places
  *
  * PARAMETERS : LocationData currentUserLocation   : Starting location
  *              Address addressOfDestination       : Destination position
  *
  * RETURNS : NONE
  */
  _drawRouteLines(LocationData currentUserLocation, Address addressOfDestination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDHE8W8R0E0da0alpKBKXSdKszn601OB7Y", // Google Maps API Key
      PointLatLng(currentUserLocation.latitude, currentUserLocation.longitude),
      PointLatLng(addressOfDestination.coordinates.latitude, addressOfDestination.coordinates.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );

    polylines[id] = polyline;
  }





  @override
  void initState() {
    super.initState();
    _getInitialLocation();
  }



  /*
  * FUNCTION : _getDestinationCoordinates()
  *
  * DESCRIPTION : This function gets the destination address from the textfield and retrieves
  *               the address using geocoder. The coordinates are extracted from the address
  *
  * PARAMETERS : NONE
  *
  * RETURNS : NONE
  */
  _getDestinationCoordinates() async {

    if (markers.isNotEmpty) markers.clear();
    if (polylines.isNotEmpty) polylines.clear();
    if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();


    _getInitialLocation();

    //Get address from text field
    String destination = destinationAddressController.text;

    var addresses = await Geocoder.local.findAddressesFromQuery(destination);
    destinationAddress = addresses.first;

    print("${destinationAddress.featureName} : ${destinationAddress.coordinates}");

    updateDestinationMarker(destinationAddress);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColor
                  ]),
            ),
            child: Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Route Search",
                          style:
                          TextStyle(fontSize: 30.0, color: Colors.yellow),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        width: kLargeMargin,
                      ),
                      Flexible(
                        child: Hero(
                          tag: 'logo',
                          child: Image(
                            height: 125,
                            image: AssetImage('images/logo.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Search",
                      style: TextStyle(fontSize: 30.0, color: Colors.yellow),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  SizedBox(
                    height: kSmallMargin,
                    width: kSmallMargin,
                  ),

                  Container(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Enter Address, Site Name, City...',
                      ),
                      controller: destinationAddressController,

                    ),
                  ),

                  SizedBox(
                    height: kSmallMargin,
                    width: kSmallMargin,
                  ),

                  SizedBox(
                    height: kSmallMargin,
                    width: kSmallMargin,
                  ),

                  Container(
                    child: FlatButton(
                      child: Text(
                        'Plan Route',
                        style: TextStyle(fontSize: 20),
                      ),
                      minWidth: 150,
                      color: Colors.yellow,
                      textColor: Colors.black,
                      onPressed: _getDestinationCoordinates,
                    ),
                  ),

                  SizedBox(
                    height: kSmallMargin,
                    width: kSmallMargin,
                  ),

                  Expanded(
                      flex: 1,
                      child: Container(
                          constraints: BoxConstraints.expand(),
                          height: 200,
                          child: GoogleMap(
                            markers: Set<Marker>.from(markers),
                            mapType: MapType.normal,
                            initialCameraPosition: _initialLocation,
                            polylines: Set<Polyline>.of(polylines.values),
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                          ))),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          child: Text(
                            'Start GPS',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: TextButton.styleFrom(
                            primary: Colors.yellow,
                            backgroundColor: Colors.black,
                          ),
                          onPressed: _getCurrentLocation,
                        ),
                      ),
                      SizedBox(
                        width: kLargeMargin,
                      ),
                      Flexible(
                        child: FlatButton(
                          child: Text(
                            'Stop GPS',
                            style: TextStyle(fontSize: 20),
                          ),
                          minWidth: 200,
                          color: Colors.black,
                          textColor: Colors.yellow,
                          onPressed: _stopGettingLocation,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }


}
