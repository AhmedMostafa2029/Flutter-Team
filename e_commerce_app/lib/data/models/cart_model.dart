
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  List<Map<String, dynamic>> products = [];
  double totalPrice = 0;
  int productsCount = 0;
  int get length => products.length;
  int get productCount => productsCount;

  void addProduct(Map<String, dynamic> product) {
    productsCount++;
    if (products.contains(product['Product'])) {
      
      increaseQuantity(products.indexOf(product));
    } else {
      products.add({'Product': product['Product'], 'quantity': 1});
    }
    totalPrice += product['Product'].price;
    notifyListeners();
  }

  void toggleProductSelection(int index, bool isSelected) {
    products[index]['selected'] = isSelected;
    notifyListeners();
  }

  void increaseQuantity(int index) {
    productsCount++;
    products[index]['quantity']++;
    totalPrice += products[index]['Product'].price;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (products[index]['quantity'] > 1) {
      productsCount--;
      products[index]['quantity']--;
      totalPrice -= products[index]['Product'].price;
      notifyListeners();
    }
  }

  void removeProduct(int index) {
    productsCount--;
    totalPrice -=
        products[index]['Product'].price * products[index]['quantity'];
    products.removeAt(index);
    notifyListeners();
  }
}
