// locations_model.dart
import 'package:flutter/material.dart';

class LocationsModel extends ChangeNotifier {
  List<String> locations = [
    'Cairo City, Central Java',
    'New York',
    'Los Angeles',
  ];

  int get locationCount => locations.length;

  String selectedLocation = 'Select Location';

  String getLocation(int index) {
    return locations[index];
  }

  void addLocation(String location) {
    locations.add(location);
    notifyListeners();
  }

  void updateSelectedLocation(int index) {
    selectedLocation = locations[index];
    notifyListeners();
  }
}
