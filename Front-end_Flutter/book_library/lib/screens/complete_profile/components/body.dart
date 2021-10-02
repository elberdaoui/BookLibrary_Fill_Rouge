import 'package:flutter/material.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/screens/complete_profile/components/complete_profile_form.dart';
import 'package:book_library/size_config.dart';

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
              'Complete your Profile',
              style: headingStyle,
            ),
            Text(
              'Complete your details or continue \nwith social media',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.05),
            CompleteProfileForm(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              'by continuing you confirm that you agree\nwith our terms and conditions',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ));
  }
}
