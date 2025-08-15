import 'package:e_commerce_app/presentation/widgets/home/pages/account_page.dart';
import 'package:e_commerce_app/presentation/widgets/home/pages/history_page.dart';
import 'package:e_commerce_app/presentation/widgets/home/pages/home_content.dart';
import 'package:e_commerce_app/presentation/widgets/home/pages/wishlist_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pagesList = [
    HomeContentPage(),
    WishlistPage(),
    HistoryPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagesList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF67C4A7),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
