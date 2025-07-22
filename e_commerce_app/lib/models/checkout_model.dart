import 'package:flutter/material.dart';

class CheckoutModel extends ChangeNotifier {
  List<dynamic> checkoutList = [
    {
      'name': 'Air pods max by Apple',
      'variant': 'Good',
      'price': 100, 
      'image': 'assets/images/products/product3.png',
      'quantity': 1,
    },
    {
      'name': 'Laptop',
      'variant': 'very good',
      'price': 100, 
      'image': 'assets/images/products/product6.png',
      'quantity': 1,
    },
    {
      'name': 'Play Station 5',
      'variant': 'very good',
      'price': 100, 
      'image': 'assets/images/products/product4.png',
      'quantity': 1,
    },
  ];
  bool isChecked = false;
  void toggleChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }

}