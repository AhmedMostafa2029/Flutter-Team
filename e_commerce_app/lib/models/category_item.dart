import 'package:flutter/material.dart';

Widget CategoryItem(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.only(right: 20),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: Colors.blueAccent),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}
