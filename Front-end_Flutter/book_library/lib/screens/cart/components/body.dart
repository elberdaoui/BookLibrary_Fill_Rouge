// import 'package:book_library/models/Products.dart';
import 'package:book_library/models/Book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_item_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    totalAmount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sum = 0;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
          // itemCount: booksList == null ? 0 : booksList.length,
          itemCount: booksList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                direction: DismissDirection.endToStart,
                // key: Key(demoCart[index].books.id.toString()),
                key: Key(booksList[index].id.toString()),
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset('assets/icons/Trash.svg')
                    ],
                  ),
                ),
                onDismissed: (direction) async {
                  setState(() {
                    booksList.removeAt(index);
                    totalAmount;
                    print(totalAmount);
                    // print(booksList.toString());
                  });
                  // SharedPreferences pref =
                  //     await SharedPreferences.getInstance();
                  // pref.setString('book_key', Book.encode(booksList));
                },
                child: CartItemCard(
                  // cart: demoCart[index],
                  book: booksList[index],
                ),
              ),
            );
          }),
    );
  }
}
