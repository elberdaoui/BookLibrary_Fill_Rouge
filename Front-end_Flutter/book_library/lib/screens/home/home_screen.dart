import 'package:flutter/material.dart';
import 'package:book_library/enums.dart';
import 'package:book_library/screens/home/components/body.dart';
import 'package:book_library/screens/profile/components/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}
