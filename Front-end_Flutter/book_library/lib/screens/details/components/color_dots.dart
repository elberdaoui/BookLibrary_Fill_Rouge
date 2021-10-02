import 'package:flutter/material.dart';
import 'package:book_library/components/rounded_icn_btn.dart';
import 'package:book_library/models/Products.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SelectedDot extends StatelessWidget {
  const SelectedDot({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Book product;

  @override
  Widget build(BuildContext context) {
    int selectedColor = 0;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
              product.colors.length,
              (index) => ColorDot(
                    color: product.colors[index],
                    isSelected: selectedColor == index,
                  )),
          Spacer(),
          RoundedIcnBtn(iconData: Icons.remove, press: () {}),
          SizedBox(
            width: getProportionateScreenWidth(20),
          ),
          RoundedIcnBtn(iconData: Icons.add, press: () {}),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  //final Product product;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(8),
      height: getProportionateScreenHeight(40),
      width: getProportionateScreenHeight(40),
      decoration: BoxDecoration(
        //color: product.colors[0],
        shape: BoxShape.circle,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
