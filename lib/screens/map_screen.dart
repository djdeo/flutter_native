import 'package:flutter/material.dart';
import 'package:flutter_native/widgets/map_container.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart' as latLng;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  latLng.LatLng _location;
  bool isSelecting = false;

  Future<void> _getCurrent() async {
    try {
      final locData = await Location().getLocation();
      _location = latLng.LatLng(locData.latitude, locData.longitude);
      isSelecting = true;
      setState(() {});
    } catch (error) {
      print(error);
      return;
    }
  }

  @override
  void initState() {
    _getCurrent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: isSelecting
          ? MapContainer(
              location: _location,
              onTap: (point) {
                print(point);
                setState(() {
                  _location = point;
                  // close this screen and show the new location
                  Navigator.of(context).pop(_location);
                });
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ), // use dynamic latlng instead
    );
  }
}
