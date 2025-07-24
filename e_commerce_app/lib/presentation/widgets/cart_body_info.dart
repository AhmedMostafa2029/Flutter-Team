import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/data/models/checkout_model.dart';
import 'package:e_commerce_app/data/models/locations_model.dart';
import 'package:e_commerce_app/presentation/widgets/location_bottom_sheet.dart';
import 'package:e_commerce_app/presentation/widgets/number_of_product_with_add_or_remove_buttoms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBodyInfo extends StatelessWidget {
  const CartBodyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, carModel, child) {
        if (carModel.productCount == 0) {
          return const Center(child: Text('Your cart is empty'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Text('Delivery To:')),
                    Consumer<LocationsModel>(
                      builder: (context, locationsModel, child) {
                        return Text(locationsModel.selectedLocation);
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return LocationBottomSheet();
                          },
                        );
                      },
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              const SizedBox(height: 10),
              carModel.productCount == 0
                  ? const Center(child: Text('Your cart is empty'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: carModel.products.length,
                      itemBuilder: (context, index) {
                        final productData = carModel.products[index];
                        final product = productData['Product'];
                        final isSelected = productData['selected'] ?? false;

                        return Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) =>
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusColor: const Color(0xFF67C4A7),
                                fillColor: MaterialStateProperty.resolveWith((
                                  states,
                                ) {
                                  if (states.contains(MaterialState.selected)) {
                                    return const Color(0xFF67C4A7);
                                  }
                                  return Colors.white;
                                }),
                                value: isSelected,
                                onChanged: (value) {
                                  carModel.toggleProductSelection(
                                    index,
                                    value!,
                                  );

                                  final checkoutModel =
                                      Provider.of<CheckoutModel>(
                                        context,
                                        listen: false,
                                      );

                                  if (value) {
                                    checkoutModel.addProduct(
                                      product,
                                      productData['quantity'],
                                    );
                                    showSnackBarSuccess(
                                      context,
                                      '${product.title} added to cart',
                                    );
                                  } else {
                                    checkoutModel.removeProductByModel(
                                      product,
                                    ); 
                                    showSnackBarSuccess(
                                      context,
                                      '${product.title} removed from cart',
                                    );
                                  }
                                },
                              ),

                              Container(
                                width: 90,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(product.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Rate: ${product.rate} (${product.count} reviews)',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Price: \$${product.price}'),
                                          NumberOfProductWithAddOrRemoveButtoms(
                                            index: index,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
