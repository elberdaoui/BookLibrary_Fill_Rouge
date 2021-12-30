import 'package:book_library/screens/admin/components/body.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static String routeName = '/admin';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Body(),
    );
  }
}
