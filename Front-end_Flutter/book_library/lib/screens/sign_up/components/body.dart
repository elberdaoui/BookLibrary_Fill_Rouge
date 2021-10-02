import 'package:flutter/material.dart';
import 'package:book_library/components/social_card.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/screens/sign_up/components/sign_up_form.dart';
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
              SizedBox(height: SizeConfig.screenHeight! * 0.04),
              Text(
                'Register Account',
                style: headingStyle,
              ),
              Text(
                'Complete your profile details or \nsign up with social media',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.08),
              SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight! * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    socialIcon: 'assets/icons/google-icon.svg',
                    press: () {},
                  ),
                  SocialCard(
                    socialIcon: 'assets/icons/twitter.svg',
                    press: () {},
                  ),
                  SocialCard(
                    socialIcon: 'assets/icons/facebook-2.svg',
                    press: () {},
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(35),
              ),
              Text(
                'By continuing you are confirm that you \nagree with our term and policy',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
