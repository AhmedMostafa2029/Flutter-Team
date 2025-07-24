import 'package:e_commerce_app/data/models/checkout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTotalPriceAndCheckoutButtom extends StatelessWidget {
  const CartTotalPriceAndCheckoutButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutModel>(
      builder: (context, checkoutModel, child) {
        bool isEmpty = checkoutModel.productsCount == 0;
        return Container(
          height: 120,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey)),
          ),
          child: Column(
            children: [
              isEmpty
                  ? const SizedBox()
                  : Row(children: [Text(''), Icon(Icons.keyboard_arrow_up)]),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Totals',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '\$${checkoutModel.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isEmpty ? Color(0xFFF0F2F1) : Color(0xFF67C4A7),
                  ),
                  child: isEmpty
                      ? Text('Continue for Payments')
                      : Text('Select Payment Method'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
