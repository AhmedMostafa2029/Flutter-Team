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

    totalPrice += product.price;
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

  void removeProductByModel(ProductModel product) {
    final index = products.indexWhere(
      (item) => item['Product'].id == product.id,
    );

    if (index != -1) {
      totalPrice -=
          products[index]['Product'].price * products[index]['quantity'];
      productsCount = productsCount - products[index]['quantity'];
      products.removeAt(index);
      notifyListeners();
    }
  }
}
