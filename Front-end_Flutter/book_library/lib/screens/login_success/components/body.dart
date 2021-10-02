import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/screens/home/home_screen.dart';
import 'package:book_library/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight! * 0.04,
          ),
          Image.asset(
            'assets/images/success.png',
            height: SizeConfig.screenHeight! * 0.5,
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.08,
          ),
          Text(
            'Login Success',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth! * 0.7,
            child: DefaultButton(
              text: 'Back Home',
              press: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
