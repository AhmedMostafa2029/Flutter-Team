import 'package:flutter/material.dart';
import 'package:e_commerce_app/data/models/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<ProductModel> favorites = [];

  List<ProductModel> get favoritesList => favorites;

  bool isFavorite(ProductModel product) {
    return favorites.any((item) => item.id == product.id);
  }

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      favorites.removeWhere((item) => item.id == product.id);
    } else {
      favorites.add(product);
    }
    notifyListeners();
  }
}
