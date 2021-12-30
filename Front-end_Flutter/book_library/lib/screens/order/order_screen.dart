import 'package:book_library/enums.dart';
import 'package:book_library/screens/order/components/body.dart';
import 'package:book_library/screens/profile/components/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.orders,
      ),
    );
  }
}
