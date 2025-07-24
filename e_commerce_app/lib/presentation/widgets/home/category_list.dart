import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/presentation/widgets/home/category_item.dart';
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
      height: 75,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: CategoryItem(category: categories[0])),
          Expanded(child: CategoryItem(category: categories[1])),
          Expanded(child: CategoryItem(category: categories[2])),
          Expanded(child: CategoryItem(category: categories[3])),
          Expanded(child: CategoryItem(category: categories[4])),
        ],
      ),
    );
  }
}
