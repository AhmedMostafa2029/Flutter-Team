import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/data/models/checkout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberOfProductWithAddOrRemoveButtoms extends StatelessWidget {
  const NumberOfProductWithAddOrRemoveButtoms({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, carModel, _) {
        final quantity = carModel.products[index]['quantity'];

        return Row(
          children: [
            _iconAction(
              icon: Icons.remove,
              onTap: () {
                carModel.decreaseQuantity(index);
                final checkoutModel = Provider.of<CheckoutModel>(
                  context,
                  listen: false,
                );
                if (checkoutModel.length >= 1) {
                  checkoutModel.decreaseQuantity(
                    carModel.products[index]['Product'],
                  );
                }
              },
            ),
            const SizedBox(width: 4),
            Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 4),
            _iconAction(
              icon: Icons.add,
              onTap: () {
                carModel.increaseQuantity(index);
                final checkoutModel = Provider.of<CheckoutModel>(
                  context,
                  listen: false,
                );
                if (checkoutModel.length >= 1) {
                  checkoutModel.increaseQuantity(
                    carModel.products[index]['Product'],
                  );
                }
              },
            ),
            const SizedBox(width: 4),
            _iconAction(
              icon: Icons.delete_outline,
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Remove item'),
                    content: const Text(
                      'Are you sure you want to remove this product?',
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel', style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          backgroundColor: Colors.greenAccent,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Remove', style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final product = carModel
                      .products[index]['Product'];

                  carModel.removeProduct(index);

                  Provider.of<CheckoutModel>(
                    context,
                    listen: false,
                  ).removeProductByModel(product);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _iconAction({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, size: 18, color: Colors.grey),
      ),
    );
  }
}
