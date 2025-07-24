import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(product.image, fit: BoxFit.fill),
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 115, 115, 115),
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          // const SizedBox(height: 4),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: ElevatedButton.icon(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).addProduct({
                  'Product': product,
                });
                showSnackBarSuccess(context, '${product.title} added to cart');
              },

              label: const Text(
                "Add to cart",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff67C4A7),
                fixedSize: Size(150, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
