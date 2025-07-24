
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/data/repositerse/get_all_category.dart';
import 'package:e_commerce_app/presentation/widgets/home/prouduct_card.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<ProductModel> products;
  bool isLoading = true;
  final GetAllCategory getAllCategory = GetAllCategory();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    products = await getAllCategory.getAllProducts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (products.isEmpty) {
      return const Center(child: Text("No products available"));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 9,
          mainAxisSpacing: 8,
        mainAxisExtent: 217,
      ),
      padding: EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
