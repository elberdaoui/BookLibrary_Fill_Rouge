import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/constants.dart';

import 'profile_menu.dart';
import 'profile_photo.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
          press: () {},
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
          press: () {},
        ),
      ],
    );
  }
}
