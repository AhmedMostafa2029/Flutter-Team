import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image(
                height: 40,
                width: 60,
                image: AssetImage(category.imageicon),
              ),
            ),
            SizedBox(height: 6),
            Text(category.title, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
