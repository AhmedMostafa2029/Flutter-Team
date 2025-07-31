import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  bool isFavorite(ProductModel product) {
    return _favorites.any((item) => item.id == product.id);
  }

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
