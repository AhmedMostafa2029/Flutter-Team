import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CarModel extends ChangeNotifier {
  List<Map<String, dynamic>> products = [
    {
      'Product': ProductModel(
        id: 1,
        name: 'Air pods max by Apple',
        variant: 'Good',
        price: 100,
        image: 'assets/images/products/product3.png',
      ),
      'quantity': 1,
    },
    {
      'Product': ProductModel(
        id: 2,
        name: 'Laptop',
        variant: 'very good',
        price: 100,
        image: 'assets/images/products/product6.png',
      ),
      'quantity': 1,
    },
    {
      'Product': ProductModel(
        id: 3,
        name: 'Play Station 5',
        variant: 'very good',
        price: 100,
        image: 'assets/images/products/product4.png',
      ),
      'quantity': 2,
    },
  ];
  double totalPrice = 0;
  int get productCount => products.length;

  void addProduct(Map<String, dynamic> product) {
    products.add(product);
    totalPrice += product['Product'].price;
  }

  void toggleProductSelection(int index, bool isSelected) {
    products[index]['selected'] = isSelected;
    notifyListeners();
  }

  void increaseQuantity(int index) {
    products[index]['quantity']++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (products[index]['quantity'] > 1) {
      products[index]['quantity']--;
      notifyListeners();
    }
  }

  void removeProduct(int index) {
    products.removeAt(index);
    notifyListeners();
  }
}
