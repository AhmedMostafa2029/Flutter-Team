import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartIconWithCount extends StatelessWidget {
  const CartIconWithCount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(3),
        width: 40,
        height: 40,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: const Icon(Icons.shopping_cart_outlined, size: 28),
            ),
            Selector<CartModel, int>(
              selector: (_, cart) => cart.productCount,
              builder: (_, count, __) {
                if (count == 0) {
                  return SizedBox();
                } else {
                  return Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
