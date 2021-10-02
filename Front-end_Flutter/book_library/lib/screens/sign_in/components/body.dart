import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/components/custom_suffix_icon.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/form_error.dart';
import 'package:book_library/components/no_account.dart';
import 'package:book_library/components/social_card.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/screens/sign_in/components/sign_in_form.dart';
import 'package:book_library/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.04),
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Sign in with your email and password',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.08),
              SignInForm(),
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
                height: getProportionateScreenHeight(20),
              ),
              NoAccountText()
            ],
          ),
        ),
      ),
    ));
  }
}
