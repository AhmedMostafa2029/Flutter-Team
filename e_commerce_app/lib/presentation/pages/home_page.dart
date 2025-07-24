
import 'package:e_commerce_app/presentation/widgets/banner_card.dart';
import 'package:e_commerce_app/presentation/widgets/category_list.dart';
import 'package:e_commerce_app/presentation/widgets/custom_home_app_bar.dart';
import 'package:e_commerce_app/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Home AppBar 
            CustomHomeAppBar(),


            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: const Color.fromARGB(255, 239, 239, 239),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            // SizedBox(height: 5),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          BannerCard(
                            image: 'assets/images/banners/banner1.png',
                          ),
                          BannerCard(
                            image: 'assets/images/banners/banner2.png',
                          ),
                          BannerCard(
                            image: 'assets/images/banners/banner3.png',
                          ),
                          // BannerCard(image: ''),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 8)),
                  SliverToBoxAdapter(child: CategoryList()),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Products",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list, size: 18),
                          label: Text("Filters"),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(child: ProductList()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
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
