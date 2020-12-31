import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:latlong/latlong.dart' as latLng;

import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage, latLng.LatLng location) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: PlaceLocation(latitude: location.latitude, longitude: location.longitude),
    );

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat':newPlace.location.latitude,
      'loc_lng':newPlace.location.longitude,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
