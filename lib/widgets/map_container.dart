import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLng;

class MapContainer extends StatelessWidget {
  final latLng.LatLng location;
  final Function onTap;

  MapContainer({this.location, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: FlutterMap(
        options: MapOptions(
            zoom: 13.0,
            center: latLng.LatLng(location.latitude, location.longitude),
            onTap: (point) {
              onTap(point);
            }),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: [
            Marker(
              width: 40,
              height: 40,
              point: latLng.LatLng(location.latitude, location.longitude),
              builder: (ctx) => Container(
                child: Icon(Icons.location_on_rounded, color: Colors.red[700]),
              ),
            )
          ])
        ],
      ),
    );
  }
}
