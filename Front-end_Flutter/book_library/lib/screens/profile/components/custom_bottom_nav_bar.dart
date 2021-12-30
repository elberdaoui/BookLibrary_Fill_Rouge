import 'package:book_library/screens/managing_books/manage_screen.dart';
import 'package:book_library/screens/order/order_screen.dart';
import 'package:book_library/screens/wish_list/wish_list_screen.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../enums.dart';
import '../profile_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  SecureStorage _storage = SecureStorage();
  late Map<String, dynamic> payload = {};
  String? jwt;
  getPayload() async {
    jwt = await _storage.readData('jwt');
    Map<String, dynamic> payloadList = await _storage.getTokenClaims(jwt!);
    setState(() {
      payload = payloadList;
    });
  }

  @override
  void initState() {
    getPayload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15)),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () =>
                  // Navigator.pushNamed(context, HomeScreen.routeName),
                  payload['roles'] == 'Admin'
                      ? Navigator.pushNamed(context, ManageScreen.routeName)
                      : Navigator.pushNamed(context, HomeScreen.routeName),
              icon: SvgPicture.asset(
                'assets/icons/Shop Icon.svg',
                color: MenuState.home == widget.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, WishListScreen.routeName);
              },
              icon: SvgPicture.asset(
                'assets/icons/Heart Icon.svg',
                color: MenuState.favorite == widget.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, OrderScreen.routeName),
              icon: SvgPicture.asset(
                // 'assets/icons/Chat bubble Icon.svg',
                'assets/icons/receipt.svg',
                color: MenuState.orders == widget.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ProfileScreen.routeName),
              icon: SvgPicture.asset(
                'assets/icons/User Icon.svg',
                color: MenuState.profile == widget.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
