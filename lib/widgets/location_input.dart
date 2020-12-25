import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutterMap;
import "package:latlong/latlong.dart" as latLng;

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
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
          child: Text(
            'No Location Chosen',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 120,
          child: flutterMap.FlutterMap(
            options: flutterMap.MapOptions(
                center: latLng.LatLng(51.5, -0.09), zoom: 13.0),
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
                    point: latLng.LatLng(51.5, -0.09),
                    builder: (ctx) => Container(
                      child: FlutterLogo(size: 10.0,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Locate Current Spot'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
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
