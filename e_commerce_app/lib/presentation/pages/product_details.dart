import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/data/models/favorite_provider.dart';
import 'package:e_commerce_app/presentation/widgets/home/cart_icon_with_count.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedColorIndex = 0;

  final List<Color> availableColors = [
    Color(0xFFFADADD),
    Color(0xFFF2F2F2),
    Color(0xFFD9EAD3),
    Color(0xFFCCE5FF),
    Color(0xFF1F1F1F),
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details product'),
        centerTitle: true,
        actions: [CartIconWithCount()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Consumer<FavoriteProvider>(
                        builder: (context, favProvider, child) {
                          final isFav = favProvider.isFavorite(product);

                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              favProvider.toggleFavorite(product);

                              final message = isFav
                                  ? '${product.title} removed from favorites'
                                  : '${product.title} added to favorites';

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: isFav
                                      ? Colors.red[400]
                                      : Colors.green[400],
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '( ${product.rating.count} people buy this )',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Choose the color",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(availableColors.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedColorIndex = index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 55,
                          height: 40,
                          decoration: BoxDecoration(
                            color: availableColors[index],
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            border: selectedColorIndex == index
                                ? Border.all(color: Colors.black, width: 2)
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage(
                          'assets/images/apple_Icon/apple_icon.jpg',
                        ),
                      ),

                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apple Store",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "online 12 mins ago",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(4),
                          ),
                        ),
                        child: Text(
                          "Follow",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Description of product",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartModel>(
                    context,
                    listen: false,
                  ).addProduct({'Product': product});
                  showSnackBarSuccess(
                    context,
                    '${product.title} added to cart',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF67C4A7),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text("Buy Now", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
