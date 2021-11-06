import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:book_library/screens/credit_card/credit_card.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/screens/cart/components/body.dart';
import 'package:book_library/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../sqlite_database.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Book bbkk;
  late SqliteDB dbHandler;
  late List<Cart> cartItems;
  late Map<String, dynamic> payload;
  SecureStorage _storage = SecureStorage();

  @override
  void initState() {
    this.dbHandler = SqliteDB();
    getCartLength();
    // getCartLength();
    totalAmount;
    cartsList.length;
    // fetchAddedBooks();
    super.initState();
  }

  getCartLength() async {
    String jwt = await _storage.readData('jwt');
    Map<String, dynamic> payload = await _storage.getTokenClaims(jwt);
    cartItems = await this.dbHandler.getItems(payload['uid']);

    setState(() {
      cartsList = cartItems;
    });
    // return cartsList;
  }

  @override
  Widget build(BuildContext context) {
    // carts = await getCartLength();
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            'Cart',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            // '${booksList.length} items',
            '${cartsList.length == 0 ? 'no' : cartsList.length} items',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}

class CheckOutCard extends StatelessWidget {
  const CheckOutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = 0;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
          vertical: getProportionateScreenHeight(15)),
      //height: 174,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: getProportionateScreenWidth(40),
                  height: getProportionateScreenHeight(40),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset('assets/icons/receipt.svg'),
                ),
                Spacer(),
                Text('Add coupon code'),
                // using 'const' to fix the width
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(text: 'Total:\n', children: [
                  TextSpan(
                      // text: '\$${context.select((Cart a) => a.total)}',
                      text: '\$${totalAmount.toDouble()}',
                      style: TextStyle(fontSize: 16, color: Colors.black))
                ])),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: 'Check Out',
                    press: () =>
                        Navigator.pushNamed(context, CreditCards.routeName),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
