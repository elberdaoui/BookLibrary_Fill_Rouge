import 'package:flutter/material.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/size_config.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.05),
              Text(
                'OTP Verification',
                style: headingStyle,
              ),
              Text('We sent you code to +212 6 55** ****'),
              buildTimer(),
              SizedBox(height: SizeConfig.screenHeight! * 0.15),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight! * 0.1),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Resend OTP code',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This code will expire on'),
        TweenAnimationBuilder(
          tween: IntTween(begin: 60, end: 0),
          duration: Duration(seconds: 60),
          builder: (context, value, child) => Text(
            '0.${value.hashCode}',
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {},
        )
      ],
    );
  }
}
