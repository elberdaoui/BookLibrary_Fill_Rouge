import 'package:book_library/models/Order.dart';
import 'package:book_library/services/storage.dart';
import 'package:book_library/size_config.dart';
import 'package:book_library/sqlite_database.dart';
import 'package:flutter/material.dart';

import 'order_item_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late SqliteDB _db;
  late List<Order> orders = [];
  late Map<String, dynamic> payload;
  SecureStorage _storage = SecureStorage();

  @override
  void initState() {
    this._db = SqliteDB();
    getOrderItems();
    super.initState();
  }

  getOrderItems() async {
    String jwt = await _storage.readData('jwt');
    payload = await _storage.getTokenClaims(jwt);
    List<Order> ordersList = await this._db.getItemsOrder(payload['uid']);
    setState(() {
      orders = ordersList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: orders.length == 0
          ? Center(
              child: Container(
                child: Text('You don\'t have any order yet make one'),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: OrderItemCard(
                    order: orders[index],
                  ),
                );
              }),
    );
  }
}
