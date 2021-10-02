import 'package:flutter/material.dart';

import '../size_config.dart';

class RoundedIcnBtn extends StatelessWidget {
  const RoundedIcnBtn({
    Key? key,
    required this.iconData,
    required this.press,
  }) : super(key: key);

  final IconData iconData;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(40),
      width: getProportionateScreenWidth(40),
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        color: Colors.white,
        onPressed: press,
        child: Icon(iconData),
      ),
    );
  }
}
