import 'dart:convert';
import 'dart:typed_data';

import 'package:book_library/models/Book.dart';
import 'package:book_library/models/WishList.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:book_library/models/Products.dart';

import '../constants.dart';
import '../size_config.dart';
import '../sqlite_database.dart';

class ProductCard extends StatefulWidget {
  // double scWidth = MediaQuery.of(context).size.width;
  ProductCard({
    Key? key,
    required this.product,
    // this.width = 140,
    this.aspectRatio = 1.02,
    required this.press,
    this.wishList,
  }) : super(key: key);

  final Book product;
  // final double width;
  final double aspectRatio;
  final GestureTapCallback press;
  final WishList? wishList;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late SqliteDB dbHandler;
  SecureStorage _storage = SecureStorage();
  // late List<int> base64;
  @override
  void initState() {
    this.dbHandler = SqliteDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        bottom: getProportionateScreenWidth(20),
      ),
      child: GestureDetector(
        onTap: widget.press,
        child: SizedBox(
          width: getProportionateScreenWidth(scWidth),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  // child: Image.asset(widget.product.photo),
                  child: Image.memory(
                    base64Decode(widget.product.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.product.bookName != null
                    ? widget.product.bookName
                    : 'default',
                maxLines: 2,
                style: TextStyle(color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${widget.product.price}',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async {
                      // bool fav = widget.product.isFav;
                      String jwt = await _storage.readData('jwt');
                      Map<String, dynamic> payload =
                          await _storage.getTokenClaims(jwt);
                      setState(() {
                        // if (widget.product.isFav) {
                        //   widget.product.newIsFav = false;
                        // } else {
                        //   widget.product.newIsFav = true;
                        // }
                        if (widget.wishList != null &&
                            widget.wishList!.isFav == 1) {
                          WishList wish = WishList(
                              uid: payload['uid'],
                              bookId: widget.product.id,
                              bookName: widget.product.bookName,
                              photo: widget.product.photo,
                              price: widget.product.price,
                              isFav: false);
                          this.dbHandler.openDB().whenComplete(() async =>
                              await this.dbHandler.updateWishlistItems(
                                  id: widget.wishList!.id, wishList: wish));
                        } else {
                          WishList wish = WishList(
                              uid: payload['uid'],
                              bookId: widget.product.id,
                              bookName: widget.product.bookName,
                              photo: widget.product.photo,
                              price: widget.product.price,
                              isFav: true);
                          this.dbHandler.openDB().whenComplete(() async =>
                              await this.dbHandler.insertWishlistItems(wish));
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                      width: getProportionateScreenWidth(28),
                      height: getProportionateScreenHeight(28),
                      // decoration: BoxDecoration(
                      //   color: widget.product.isFav
                      //       ? kPrimaryColor.withOpacity(0.15)
                      //       : kSecondaryColor.withOpacity(0.1),
                      //   borderRadius: BorderRadius.circular(15),
                      //   // shape: BoxShape.circle,
                      // ),
                      child: SvgPicture.asset(
                        'assets/icons/Heart Icon_2.svg',
                        // color: widget.product.isFav
                        //     ? Color(0xFFFF4848)
                        //     : Color(0xFFD8DED4),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
