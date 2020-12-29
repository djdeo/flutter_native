import 'package:flutter/material.dart';
import 'package:flutter_native/widgets/map_container.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Screen'),),
      body: MapContainer(37.42, -122.08), // use dynamic latlng instead
    );
  }
}