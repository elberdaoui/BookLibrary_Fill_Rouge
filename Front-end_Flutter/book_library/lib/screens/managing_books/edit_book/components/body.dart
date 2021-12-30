import 'package:book_library/screens/managing_books/components/manage_books_form.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight! * 0.02),
            Text(
              'Enter the info',
              style: headingStyle,
            ),
            ManageBooksForm(),
          ],
        ),
      ),
    ));
  }
}
