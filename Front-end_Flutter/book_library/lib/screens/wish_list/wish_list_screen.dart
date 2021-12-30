import 'package:book_library/screens/profile/components/custom_bottom_nav_bar.dart';
import 'package:book_library/screens/wish_list/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class WishListScreen extends StatelessWidget {
  static String routeName = '/wishlist';
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wish List'),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.favorite,
      ),
    );
  }
}
