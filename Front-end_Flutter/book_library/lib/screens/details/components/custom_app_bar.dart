import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/components/rounded_icn_btn.dart';

import '../../../size_config.dart';

//ignore: must_be_immutable
class CustomAppBar extends PreferredSize {
  double? rating;
  CustomAppBar({this.rating})
      : super(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBar());
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedIcnBtn(
                iconData: Icons.arrow_back,
                press: () => Navigator.pop(context)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  Text(
                    rating.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset('assets/icons/Star Icon.svg')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
