import 'dart:convert';
import 'dart:typed_data';

import 'package:book_library/models/Book.dart';
import 'package:flutter/material.dart';
// import 'package:book_library/models/Products.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Book product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  late final base64;

  // static String byteConvert() {
  //   String base64 = '';
  //   return base64Encode();
  //   // base64 = Base64Encoder().convert(input);
  //   // return Base64Codec().decode(base64);
  // }

  @override
  void initState() {
    setState(() {
      // base64 = Book.byteConvert(widget.product.photo.asInt64List());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            // child: Image.asset(widget.product.images[selectedImage]),
            child: Image.memory(
              base64Decode(widget.product.photo),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ...List.generate(
            //     base64.length, (index) => buildSmallPreviews(index))
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallPreviews(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        height: getProportionateScreenHeight(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: selectedImage == index
                    ? kPrimaryColor
                    : Colors.transparent)),
        child: Image.asset(base64[index]),
      ),
    );
  }
}
