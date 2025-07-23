import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});
  final List<CategoryModel> categories = const [
    CategoryModel(
      imageicon: 'assets/images/categorys/img1.png',
      title: "Apparel",
    ),
    CategoryModel(
      imageicon: 'assets/images/categorys/img2.png',
      title: "School",
    ),
    CategoryModel(
      imageicon: 'assets/images/categorys/img3.png',
      title: "Sports",
    ),
    CategoryModel(
      imageicon: 'assets/images/categorys/img4.png',
      title: "Electronic",
    ),
    // CategoryModel(imageicon: 'assets/images/categorys/img5.png', title: "Bag"),
    CategoryModel(imageicon: 'assets/images/categorys/img5.png', title: "All"),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryItem(category: categories[index]);
        },
      ),
    );
  }
}
