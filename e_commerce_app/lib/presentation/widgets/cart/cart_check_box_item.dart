import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/data/models/checkout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCheckBoxItem extends StatelessWidget {
  const CartCheckBoxItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    
    return Consumer<CartModel>(
      builder: (context, cartModel, child) {
        final productData = cartModel.products[index];
                        final product = productData['Product'];
                        final isSelected = productData['selected'] ?? false;
        return Checkbox(
          side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(color: Colors.grey),
          ),
          focusColor: const Color(0xFF67C4A7),
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF67C4A7);
            }
            return Colors.white;
          }),
          value: isSelected,
          onChanged: (value) {
            cartModel.toggleProductSelection(index, value!);

            final checkoutModel = Provider.of<CheckoutModel>(
              context,
              listen: false,
            );

            if (value) {
              checkoutModel.addProduct(product, productData['quantity']);
            } else {
              checkoutModel.removeProductByModel(product);
            }
          },
        );
      },
    );
  }
}
