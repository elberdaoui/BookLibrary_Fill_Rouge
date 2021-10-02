import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    this.image,
    this.text,
    Key? key,
  }) : super(key: key);

  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          'SMART LIBRARY',
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: getProportionateScreenWidth(36),
              fontWeight: FontWeight.bold),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(
          flex: 2,
        ),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        )
      ],
    );
  }
}
