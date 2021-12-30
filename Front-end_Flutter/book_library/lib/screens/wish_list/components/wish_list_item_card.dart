import 'dart:convert';

import 'package:book_library/models/WishList.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class WishListItemCard extends StatelessWidget {
  const WishListItemCard({Key? key, this.wishList}) : super(key: key);
  final WishList? wishList;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              // child: Image.asset(cart.books.images[0]),
              // child: Image.asset(book.images[0]),
              // child: Image.memory(Book.byteConvert(book.photo.asInt64List())),
              child: Image.memory(
                // base64Decode(book.photo),
                // base64Decode(cart!.photo!),
                base64Decode(wishList!.photo),
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(20),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // cart.books.title,
                // book.bookName,
                // cart!.bookName!,
                wishList!.bookName,
                overflow: TextOverflow.ellipsis,
                // textAlign: TextAlign.left,
                // textWidthBasis: TextWidthBasis.longestLine,
                // demoCart[0].books.title,
                // booksList[index].title,
                style: TextStyle(color: Colors.black, fontSize: 15),
                maxLines: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Text.rich(TextSpan(
                  // text: '\$${cart.books.price}',
                  // text: '\$${cart.books.price}',
                  // text: '\$${book.price}',
                  text: '\$${wishList!.price}',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                  children: [
                    // TextSpan(
                    //     text: ' x${order!.numOfitems}',
                    //     // text: 'x${book.quantity}',
                    //     style: TextStyle(color: kTextColor)),
                  ]))
            ],
          ),
        )
      ],
    );
    ;
  }
}
