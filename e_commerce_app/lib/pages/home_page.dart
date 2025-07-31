import 'package:e_commerce_app/presentation/widgets/home/BottomNavigationBar/account_page.dart';
import 'package:e_commerce_app/presentation/widgets/home/BottomNavigationBar/history_page.dart';
import 'package:e_commerce_app/presentation/widgets/home/BottomNavigationBar/home_content.dart';
import 'package:e_commerce_app/presentation/widgets/home/BottomNavigationBar/wishlist_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContentPage(),
    WishlistPage(),
    HistoryPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF67C4A7),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
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
