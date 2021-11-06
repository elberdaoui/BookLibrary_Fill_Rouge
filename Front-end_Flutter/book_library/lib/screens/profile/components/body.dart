import 'package:book_library/models/Cart.dart';
import 'package:book_library/screens/sign_in/sign_in_screen.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/constants.dart';

import 'profile_menu.dart';
import 'profile_photo.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SecureStorage _storage = SecureStorage();
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfilePhoto(),
        SizedBox(
          height: 20,
        ),
        ProfileMenu(
          icon: 'assets/icons/User Icon.svg',
          text: 'My Account',
          press: () {
            for (var cart in cartsList) {
              print(cart.uid);
            }
          },
        ),
        ProfileMenu(
          icon: 'assets/icons/Bell.svg',
          text: 'Notifications',
          press: () {},
        ),
        ProfileMenu(
          icon: 'assets/icons/Settings.svg',
          text: 'Settings',
          press: () {},
        ),
        ProfileMenu(
          icon: 'assets/icons/Question mark.svg',
          text: 'Help Center',
          press: () {},
        ),
        ProfileMenu(
          icon: 'assets/icons/Log out.svg',
          text: 'Log Out',
          press: () {
            _storage.deleteData('jwt').whenComplete(() =>
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (Route route) => false));
          },
        ),
      ],
    );
  }
}
