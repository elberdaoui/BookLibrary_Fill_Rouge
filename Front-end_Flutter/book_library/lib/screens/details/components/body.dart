import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Cart.dart';
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
  late List<Map> listTemp;
  String fData = "[]";
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
                                        '${widget.book.bookName} added to art'),
                                  ));
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    Map<String, dynamic> fetchData =
                                        jsonDecode(pref.getString('book_key')!);
                                    // Book bbkk = Book.fromObject(fetchData);

                                    if (fetchData.length > 0) {
                                      for (int i = 0;
                                          i < fetchData.length;
                                          i++) {
                                        if (fetchData[i] != null) {
                                          Map<String, dynamic> mapp =
                                              fetchData[i];
                                          booksList.add(Book.fromObject(mapp));
                                        }
                                      }
                                    }
                                    // booksList.add(bbkk);
                                    booksList.add(widget.book);
                                    print(booksList.toList());
                                  });
                                  // Book bk = Book(
                                  //     widget.book.bookName,
                                  //     widget.book.description,
                                  //     widget.book.price,
                                  //     widget.book.photo,
                                  //     widget.book.publishedDate,
                                  //     widget.book.isFav,
                                  //     widget.book.rating);

                                  var dataa = Book.toMappp(widget.book);
                                  // print(widget.book.toMap());
                                  data = jsonEncode(dataa);

                                  // pref.setString('book_key', data);

                                  var sm = Book.encode(booksList);
                                  print(sm);
                                  pref.setString('book_key', sm);
                                  // fData = pref.getString('book_key_2')!;
                                  // var temp = fData == null
                                  //     ? []
                                  //     : json.decode(fData.toString());
                                  // listTemp = (temp as List).cast();
                                  // listTemp.add(dataa);
                                  // fData = json.encode(listTemp).toString();
                                  // print(fData);
                                  // print('_____________');
                                  // pref.setString('book_key_2', fData);
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
