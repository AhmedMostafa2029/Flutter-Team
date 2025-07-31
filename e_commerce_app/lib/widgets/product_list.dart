import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/widgets/prouduct_card.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});

  final List<ProductModel> products = [
    // ProductModel(id: 1, name: 'Monitor LG 4K', variant: "", price: 599, image: 'assets/images/products/product1.png'),
    ProductModel(
      image: 'assets/images/products/product1.png',
      title: 'Monitor LG 4K',
      price: 599,
      id: 1,
      variant: '',
    ),
    ProductModel(
      image: 'assets/images/products/product2.png',
      title: 'Aestechic Mug-white',
      price: 199,
      id: 2,
      variant: '',
    ),
    ProductModel(
      image: 'assets/images/products/product3.png',
      title: 'Earphones',
      price: 295,
      id: 3,
      variant: '',
    ),
    ProductModel(
      image: 'assets/images/products/product4.png',
      title: 'PlayStation',
      price: 100,
      id: 4,
      variant: '',
    ),
    ProductModel(
      image: 'assets/images/products/product5.png',
      title: 'T-shirt ',
      price: 299,
      id: 5,
      variant: '',
    ),
    ProductModel(
      image: 'assets/images/products/product6.png',
      title: 'Laptop ',
      price: 1099,
      id: 6,
      variant: '',
    ),
    ProductModel(
      image: 'assets/images/products/product7.png',
      title: 'camera ',
      price: 599,
      id: 7,
      variant: '',
    ),
    ProductModel(
      image: 'assets/images/products/product8.png',
      title: 'Hoodie ',
      price: 399,
      id: 8,
      variant: '',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
