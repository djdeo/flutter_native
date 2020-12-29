import 'package:flutter/material.dart';
import 'package:flutter_native/screens/map_screen.dart';
import 'package:flutter_native/widgets/map_container.dart';
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

    return MapContainer(lat, lng);
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

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, // show close button instead of the back button
        builder: (ctx) => MapScreen()));
  }

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
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
