import 'package:e_commerce_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(E_CommerceApp());
}

class E_CommerceApp extends StatelessWidget {
  const E_CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
