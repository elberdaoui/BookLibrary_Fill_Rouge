import 'package:book_library/screens/credit_card/existing_credit_card/components/body.dart';
import 'package:flutter/material.dart';

class ExistingCardScreen extends StatelessWidget {
  static String routeName = '/existing_card';
  const ExistingCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Existing Credit Card'),
      ),
      body: Body(),
    );
  }
}
