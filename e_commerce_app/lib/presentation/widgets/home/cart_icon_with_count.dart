import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
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
        padding: EdgeInsets.all(4),
        width: 40,
        height: 40,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: const Icon(IconsaxPlusLinear.shopping_cart, size: 28),
            ),
            Selector<CartModel, num>(
              selector: (_, cart) => cart.productCount,
              builder: (_, count, __) {
                if (count == 0) {
                  return SizedBox();
                } else {
                  return Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
