import 'package:flutter/material.dart';
import 'package:store_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:store_app/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

import 'widgets/header_widget.dart';
import 'widgets/popular_product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            BannerWidget(),
            CategoryItemWidget(),
            ReusableTextWidget(title: "Popular Products", subtitle: 'View all'),
            PopularProductWidget(),

          ],
        ),
      ),
    );
  }
}
