
import 'package:e_commerce_app/presentation/widgets/cart_body_info.dart';
import 'package:e_commerce_app/presentation/widgets/cart_icon_with_count.dart';
import 'package:e_commerce_app/presentation/widgets/cart_total_price_and_checkout_buttom.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //=========================== App Bar ================================
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CartIconWithCount(),
          ),
        ],
      ),

      //=========================== Body ================================
      body: CartBodyInfo(),

      //=========================== Nav Bar ================================
      bottomNavigationBar: CartTotalPriceAndCheckoutButtom(),
    );
  }
}
