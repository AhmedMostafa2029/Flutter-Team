import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
      ),
      body: Consumer<CarModel>(
        builder: (context, carModel, child) {
          if (carModel.productCount == 0) {
            return const Center(child: Text('Your cart is empty'));
          }

          return ListView.builder(
            itemCount: carModel.productCount,
            itemBuilder: (context, index) {
              final productData = carModel.products[index];
              final product = productData['Product'];
              final isSelected = productData['selected'] ?? false;

              return Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        carModel.toggleProductSelection(index, value!);
                      },
                    ),
                    SizedBox(
                      width: 90,
                      height: 100,
                      child: Image(
                        image: AssetImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Variant: ${product.variant}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          );
        },
      ),
    );
  }
}

//==============================================================================
class NumberOfProductWithAddOrRemoveButtoms extends StatelessWidget {
  const NumberOfProductWithAddOrRemoveButtoms({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<CarModel>(
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
            Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
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
                    content: const Text(
                      'Are you sure you want to remove this product?',
                    ),
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
                child: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
