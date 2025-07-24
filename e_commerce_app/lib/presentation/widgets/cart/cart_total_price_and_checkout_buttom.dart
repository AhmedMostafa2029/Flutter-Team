import 'dart:developer';
import 'package:e_commerce_app/data/models/checkout_model.dart';
import 'package:e_commerce_app/presentation/widgets/cart/order_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTotalPriceAndCheckoutButtom extends StatefulWidget {
  const CartTotalPriceAndCheckoutButtom({super.key});

  @override
  State<CartTotalPriceAndCheckoutButtom> createState() =>
      _CartTotalPriceAndCheckoutButtomState();
}

class _CartTotalPriceAndCheckoutButtomState
    extends State<CartTotalPriceAndCheckoutButtom> {
  bool cleckedSummaryButton = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutModel>(
      builder: (context, checkoutModel, child) {
        bool isEmpty = checkoutModel.productsCount == 0;
        if (isEmpty) {
          cleckedSummaryButton = false;
        }
        return Container(
          height: cleckedSummaryButton ? 400 : 130,
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
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Samary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              cleckedSummaryButton = !cleckedSummaryButton;
                              log(
                                'cleckedSummaryButton: $cleckedSummaryButton',
                              );
                            });
                          },
                          child: Icon(
                            cleckedSummaryButton
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Totals',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    '\$${checkoutModel.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              cleckedSummaryButton ? OrderDetails() : const SizedBox(),
              Spacer(flex: 1),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
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
                        : Text(
                            'Select Payment Method',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
