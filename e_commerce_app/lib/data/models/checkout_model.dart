import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:flutter/material.dart';

class CheckoutModel extends ChangeNotifier {
  List<Map<String, dynamic>> products = [];
  double totalPrice = 0;
  num productsCount = 0;
  int get length => products.length;
  get productCount => productsCount;

  void addProduct(ProductModel product, int quantity) {
    productsCount += quantity;

    products.add({'Product': product, 'quantity': quantity});

    totalPrice += product.price * quantity;
    notifyListeners();
  }

  void toggleProductSelection(int index, bool isSelected) {
    products[index]['selected'] = isSelected;
    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    for (var i = 0; i < length; i++) {
      if (products[i]['Product'] == product) {
        products[i]['quantity']++;
        productsCount++;
        totalPrice += product.price;
        notifyListeners();
        return;
      }
    }
  }

  void decreaseQuantity(ProductModel product) {
    for (var i = 0; i < length; i++) {
      if (products[i]['Product'].id == product.id &&
          products[i]['quantity'] > 1) {
        products[i]['quantity']--;
        totalPrice -= product.price;
        productsCount--;
        notifyListeners();
        return;
      }
    }
    if (productsCount == 0) {
      totalPrice = 0;
    }
    notifyListeners();
  }

  void removeProductByModel(ProductModel product) {
    for (var i = 0; i < length; i++) {
      if (products[i]['Product'] == product) {
        totalPrice -= products[i]['Product'].price * products[i]['quantity'];
        productsCount -= products[i]['quantity'];
        products.removeAt(i);
        notifyListeners();
        return;
      }
    }
  }
}
