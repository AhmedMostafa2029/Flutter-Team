import 'package:e_commerce_app/data/models/checkout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutModel>(
      builder: (context, checkoutModel, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            height: 250,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Price',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  ListView.builder(
                    itemCount: checkoutModel.products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = checkoutModel.products[index]['Product'];
                      final quantity =
                          checkoutModel.products[index]['quantity'];
                      final totalPrice = product.price * quantity;

                      return SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Expanded(child: Text('$quantity')),
                            Text('\$$totalPrice'),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
