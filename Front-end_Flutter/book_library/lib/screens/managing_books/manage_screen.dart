import 'package:book_library/enums.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/screens/managing_books/add_book/add_book_screen.dart';
import 'package:book_library/screens/managing_books/edit_book/edit_book_screen.dart';
import 'package:book_library/screens/profile/components/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class ManageScreen extends StatelessWidget {
  static String routeName = '/manage';
  const ManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage'),
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, AddBookScreen.routeName);
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}
