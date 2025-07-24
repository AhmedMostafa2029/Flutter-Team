import 'package:e_commerce_app/data/models/cart_model.dart';
import 'package:e_commerce_app/data/models/checkout_model.dart';
import 'package:e_commerce_app/data/models/locations_model.dart';
import 'package:e_commerce_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => LocationsModel()),
        ChangeNotifierProvider(create: (context) => CheckoutModel()),
      ],
      child: const E_CommerceApp(),
    ),
  );
}

// ignore: camel_case_types
class E_CommerceApp extends StatelessWidget {
  const E_CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
