import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: Container(
        height: 120,
        width: 220,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image)),
          color: const Color.fromARGB(255, 252, 252, 252),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
