

import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberOfProductWithAddOrRemoveButtoms extends StatelessWidget {
  const NumberOfProductWithAddOrRemoveButtoms({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, carModel, _) {
        int quantity = carModel.products[index]['quantity'];

        return Row(
          children: [
            GestureDetector(
              onTap: () {
                carModel.decreaseQuantity(index);
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.remove, size: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              quantity.toString(),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 2),
            GestureDetector(
              onTap: () {
                carModel.increaseQuantity(index);
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.add, size: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 3),
            GestureDetector(
              onTap: () async {
                final confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Remove item'),
                    content: const Text('Are you sure you want to remove this product?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  carModel.removeProduct(index);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.delete_outline, size: 18, color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
