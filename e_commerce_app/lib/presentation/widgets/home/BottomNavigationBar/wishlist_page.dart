import 'package:e_commerce_app/presentation/pages/product_details.dart';
import 'package:e_commerce_app/data/models/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/data/models/product_model.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: Text('Wishlist'), centerTitle: true),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final ProductModel product = favorites[index];

                return ListTile(
                  leading: Image.network(product.image, width: 50),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                  trailing: Icon(Icons.favorite, color: Colors.red),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
