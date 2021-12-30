import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Order.dart';
// import 'package:book_library/models/Products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_library/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    Key? key,
    this.cart,
    this.book,
    this.order,
  }) : super(key: key);

  final Book? book;
  final Cart? cart;
  final Order? order;

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
                base64Decode(order!.photo),
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
                order!.bookName,
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
                  text: '\$${order!.price}',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                  children: [
                    TextSpan(
                        text: ' x${order!.numOfitems}',
                        // text: 'x${book.quantity}',
                        style: TextStyle(color: kTextColor))
                  ]))
            ],
          ),
        )
      ],
    );
  }
}
