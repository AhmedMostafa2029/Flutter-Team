import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(category.icon, size: 28, color: Colors.blueAccent),
            ),
            SizedBox(height: 8),
            Text(category.title, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
