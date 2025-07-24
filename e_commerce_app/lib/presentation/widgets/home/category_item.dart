import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final CategoryModel category;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image(
              height: 50,
              image: AssetImage(category.imageicon),
            ),
          ),
          SizedBox(height: 6),
          Text(category.title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
