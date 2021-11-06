import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/services/storage.dart';
import 'package:book_library/sqlite_database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/rounded_icn_btn.dart';
import 'package:book_library/constants.dart';
// import 'package:book_library/models/Products.dart';
import 'package:book_library/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'top_rounded_container.dart';

class Body extends StatefulWidget {
  final Book book;

  Body({Key? key, required this.book}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String data;
  SecureStorage _storage = SecureStorage();
  late List<Map> listTemp;
  String fData = "[]";
  late SqliteDB dbHandler;
  late Cart ct;
  @override
  void initState() {
    this.dbHandler = SqliteDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(product: widget.book),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: widget.book,
                  pressOn: () {},
                ),
                TopRoundedContainer(
                    color: Color(0xFFF6F7F9),
                    child: Column(
                      children: [
                        // SelectedDot(product: product),
                        TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth! * 0.15,
                                right: SizeConfig.screenWidth! * 0.15,
                                top: getProportionateScreenHeight(15),
                                bottom: getProportionateScreenHeight(40),
                              ),
                              child: DefaultButton(
                                text: 'Add to cart',
                                press: () async {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text(
                                        '${widget.book.bookName} added to cart'),
                                  ));
                                  // SharedPreferences pref =
                                  //     await SharedPreferences.getInstance();
                                  // FirebaseFirestore firestore =
                                  //     FirebaseFirestore.instance;
                                  // await firestore
                                  //     .collection('carts')
                                  //     .add(Book.toMappp(widget.book));

                                  String jwt = await _storage.readData('jwt');
                                  Map<String, dynamic> payload =
                                      await _storage.getTokenClaims(jwt);
                                  var clist = await this
                                      .dbHandler
                                      .getItems(payload['uid']);
                                  var ddf =
                                      clist.map((e) => e.uid == payload['uid']);
                                  // var crt;
                                  // for (int i = 0; i < clist.length; i++) {
                                  //   crt = clist[i].bookId == widget.book.id;
                                  // }
                                  // print(crt);
                                  // var some = clist.where((element) => element.bookId == widget.book.id).toList();

                                  setState(() {
                                    // Map<String, dynamic> fetchData =
                                    //     jsonDecode(pref.getString('book_key')!);
                                    // Book bbkk = Book.fromObject(fetchData);

                                    // if (fetchData.length > 0) {
                                    //   for (int i = 0;
                                    //       i < fetchData.length;
                                    //       i++) {
                                    //     if (fetchData[i] != null) {
                                    //       Map<String, dynamic> mapp =
                                    //           fetchData[i];
                                    //       booksList.add(Book.fromObject(mapp));
                                    //     }
                                    //   }
                                    // }
                                    // booksList.add(bbkk);
                                    int count = 1;
                                    // Cart cart = Cart(
                                    //      widget.book.id,
                                    //      widget.book.bookName,
                                    //     widget.book.photo,
                                    //      widget.book.price,
                                    //      cart.id != widget.book.id
                                    //         ? count
                                    //         : count++);

                                    // var olist;
                                    // if(clist.isNotEmpty){
                                    //   olist = clist.firstWhere((element) =>
                                    //   element.bookId == widget.book.id);
                                    // }
                                    // var olist = cartsList.map((e) => e.bookId == widget.book.id);

                                    // var olist = cartsList.map((e) => e.bookId == widget.book.id);
                                    // for (int i = 0; i < clist.length; i++) {
                                    //   if (clist[i].bookId != widget.book.id &&
                                    //       ct.id == null) {
                                    //     Cart cart = Cart(
                                    //         uid: payload['uid'],
                                    //         bookId: widget.book.id,
                                    //         bookName: widget.book.bookName,
                                    //         photo: widget.book.photo,
                                    //         price: widget.book.price,
                                    //         numOfitems: count);
                                    //
                                    //     // Cart c = Cart {
                                    //     //   c.id = widget.book.id;
                                    //     //   c.numOfitems = c.id != widget.book.id?count: count++;
                                    //     //   c.price = widget.book.price;
                                    //     //   c.bookName = widget.book.bookName;
                                    //     //   c.photo = widget.book.photo;
                                    //     // };
                                    //     // Cart c = Cart();
                                    //     // c._id = widget.book.id;
                                    //     // c.newBookName = widget.book.bookName;
                                    //     // c.photo = widget.book.photo;
                                    //     // c.price = widget.book.price;
                                    //     // c.numOfitems = c.id != widget.book.id
                                    //     //     ? count
                                    //     //     : count++;
                                    //     // if (!cart.id!.contains(widget.book.id)) {
                                    //     //   this.dbHandler.openDB().whenComplete(() =>
                                    //     //       this.dbHandler.insertItems(cart));
                                    //     // } else {
                                    //     //   cart.numOfitems = cart.numOfitems! + 1;
                                    //     //   this.dbHandler.insertItems(cart);
                                    //     // }
                                    //     // if (!cart.id.contains(widget.book.id)) {
                                    //     //   this.dbHandler.openDB().whenComplete(() =>
                                    //     //       this.dbHandler.insertItems(cart));
                                    //     // } else {
                                    //     //   cart.numOfitems = cart.numOfitems + 1;
                                    //     //   // this.dbHandler.insertItems(cart);
                                    //     // }
                                    //     this.dbHandler.openDB().whenComplete(
                                    //         () async => await this
                                    //             .dbHandler
                                    //             .insertItems(cart));
                                    //     print('list is : ${clist.toList()}');
                                    //     break;
                                    //   } else {
                                    //     var olist = clist.firstWhere(
                                    //         (element) =>
                                    //             element.bookId ==
                                    //             widget.book.id);
                                    //     Cart cart = Cart(
                                    //         id: olist.id,
                                    //         uid: payload['uid'],
                                    //         bookId: widget.book.id,
                                    //         bookName: widget.book.bookName,
                                    //         photo: widget.book.photo,
                                    //         price: widget.book.price,
                                    //         numOfitems: olist.numOfitems++);
                                    //     this.dbHandler.openDB().whenComplete(
                                    //         () async => await this
                                    //             .dbHandler
                                    //             .updateItems(
                                    //                 id: olist.id, cart: cart));
                                    //     break;
                                    //   }
                                    // }

                                    Cart cart = Cart(
                                        uid: payload['uid'],
                                        bookId: widget.book.id,
                                        bookName: widget.book.bookName,
                                        photo: widget.book.photo,
                                        price: widget.book.price,
                                        numOfitems: count);
                                    this.dbHandler.openDB().whenComplete(
                                        () async => await this
                                            .dbHandler
                                            .insertItems(cart));
                                    print(cart);
                                    print('===========================');
                                    print(payload['uid']);
                                    // if (!clist.contains(widget.book.id)) {
                                    //   Cart cart = Cart(
                                    //       uid: payload['uid'],
                                    //       bookId: widget.book.id,
                                    //       bookName: widget.book.bookName,
                                    //       photo: widget.book.photo,
                                    //       price: widget.book.price,
                                    //       numOfitems: count);
                                    //   this.dbHandler.openDB().whenComplete(
                                    //       () async => await this
                                    //           .dbHandler
                                    //           .insertItems(cart));
                                    //   print('list is : ${clist.toList()}');
                                    // } else {
                                    //   var olist = clist.firstWhere((element) =>
                                    //       element.bookId == widget.book.id);
                                    //   Cart cart = Cart(
                                    //       uid: payload['uid'],
                                    //       bookId: widget.book.id,
                                    //       bookName: widget.book.bookName,
                                    //       photo: widget.book.photo,
                                    //       price: widget.book.price,
                                    //       numOfitems: olist.numOfitems++);
                                    //   this.dbHandler.openDB().whenComplete(
                                    //       () async => await this
                                    //           .dbHandler
                                    //           .updateItems(
                                    //               id: olist.id, cart: cart));
                                    // }

                                    // this.dbHandler.openDB().whenComplete(
                                    //     () => this.dbHandler.insertItems(c));
                                    // booksList.add(widget.book);
                                    // print(cart.toMap());
                                  });
                                },
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
