import 'package:flutter/material.dart';

import './screens/add_place_screen.dart';
import './screens/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Places to visit',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
      ),
      home: PlacesListScreen(),
      routes: {
        AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
      },
    );
  }
}