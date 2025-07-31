import 'package:flutter/material.dart';
import 'package:e_commerce_app/data/models/product_model.dart';

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
