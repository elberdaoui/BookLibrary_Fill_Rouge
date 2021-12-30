import 'dart:convert';

import 'package:book_library/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:book_library/enums.dart';
import 'package:book_library/screens/home/components/body.dart';
import 'package:book_library/screens/profile/components/custom_bottom_nav_bar.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}
