import 'dart:async';

import 'package:book_library/models/Cart.dart';
import 'package:book_library/models/Order.dart';
import 'package:book_library/screens/cart/cart_screen.dart';
import 'package:book_library/screens/credit_card/existing_credit_card/existing_card_srceen.dart';
import 'package:book_library/screens/home/home_screen.dart';
import 'package:book_library/services/storage.dart';
import 'package:book_library/services/stripe_service.dart';
import 'package:book_library/sqlite_database.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreditCards extends StatefulWidget {
  static String routeName = '/cards';

  CreditCards({Key? key}) : super(key: key);

  @override
  CreditCardsState createState() => CreditCardsState();
}

class CreditCardsState extends State<CreditCards> {
  late SqliteDB _sqliteDB;
  SecureStorage _storage = SecureStorage();
  late Map<String, dynamic> payload;
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.pushNamed(context, ExistingCardScreen.routeName);
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: totalAmount.toString(), currency: 'USD');
    //     .then((value) async {
    //   await dialog.hide();
    //   Scaffold.of(context).showSnackBar(SnackBar(
    //
    //     content: Text(value.message!),
    //     duration:
    //         new Duration(milliseconds: value.success == true ? 1200 : 5000),
    //   ));
    //   Navigator.pushNamed(context, CartScreen.routeName);
    // });
    // await dialog.hide();
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text(response.message!),
    //   duration:
    //       new Duration(milliseconds: response.success == true ? 1200 : 5000),
    // ));
    await dialog.hide().whenComplete(() {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(response.message!),
        duration:
            new Duration(milliseconds: response.success == true ? 1200 : 5000),
      ));
      if (response.success == true) {
        for (var cart in cartsList) {
          this
              ._sqliteDB
              .openDB()
              .whenComplete(
                  () async => await this._sqliteDB.insertItemsOrder(cart))
              .whenComplete(
                  () async => await this._sqliteDB.deleteItem(cart.id!));
          print(cart);
        }
        Timer(
            Duration(milliseconds: 1201),
            () => Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (Route route) => false));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._sqliteDB = SqliteDB();
    StripeService.init();
    final Cart? cart;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Icon? icon;
              Text? text;

              switch (index) {
                case 0:
                  icon = Icon(Icons.add_circle, color: theme.primaryColor);
                  text = Text('Pay via new card');
                  break;
                case 1:
                  icon = Icon(Icons.credit_card, color: theme.primaryColor);
                  text = Text('Pay via existing card');
                  break;
              }

              return InkWell(
                onTap: () {
                  onItemPress(context, index);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: theme.primaryColor,
                ),
            itemCount: 2),
      ),
    );
  }
}
