import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product.image,
            height: 105,
            width: 155,
            fit: BoxFit.fill,
          ),
        ),
        // const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            product.name,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 115, 115, 115),
            ),
          ),
        ),
        // const SizedBox(height: 4),
        Align(
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
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_shopping_cart),
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
      ],
    );
  }
}
