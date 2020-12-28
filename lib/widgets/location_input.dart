import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutterMap;
import "package:latlong/latlong.dart" as latLng;
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double _lat;
  double _lng;

  Widget _showMapContainer(double lat, double lng) {
    setState(() {
      _lat = lat;
      _lng = lng;
    });

    return Container(
      height: 170,
      child: flutterMap.FlutterMap(
        options: flutterMap.MapOptions(
          center: latLng.LatLng(lat, lng),
          zoom: 13.0,
        ),
        layers: [
          flutterMap.TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          flutterMap.MarkerLayerOptions(
            markers: [
              flutterMap.Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(lat, lng),
                builder: (ctx) => Container(
                  child: FlutterLogo(
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      print(locData.latitude);
      print(locData.longitude);
      _showMapContainer(locData.latitude, locData.longitude);
    } catch (error) {
      print(error);
      return;
    }
  }

  // Future<void> _selectOnMap() async {
  //   final selectedLocation =
  //       await Navigator.of(context).push(MaterialPageRoute(
  //     fullscreenDialog: true,
  //     // builder: (ctx) => MapScreen()
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _lat != null
              ? _showMapContainer(_lat, _lng)
              : Text('No place selected'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Use Current'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
