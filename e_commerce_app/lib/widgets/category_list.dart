import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});
  final List<CategoryModel> categories = const [
    CategoryModel(icon: Icons.checkroom, title: "Apparel"),
    CategoryModel(icon: Icons.school, title: "School"),
    CategoryModel(icon: Icons.sports_basketball, title: "Sports"),
    CategoryModel(icon: Icons.electrical_services, title: "Electronic"),
    CategoryModel(icon: Icons.shopping_bag_rounded, title: "Bag"),
    CategoryModel(icon: Icons.grid_view, title: "All"),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
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
