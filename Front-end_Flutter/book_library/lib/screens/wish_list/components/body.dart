import 'package:book_library/models/WishList.dart';
import 'package:book_library/screens/wish_list/components/wish_list_item_card.dart';
import 'package:book_library/services/storage.dart';
import 'package:book_library/size_config.dart';
import 'package:flutter/material.dart';

import '../../../sqlite_database.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late SqliteDB _db;
  late List<WishList> wishlist = [];
  late Map<String, dynamic> payload;
  SecureStorage _storage = SecureStorage();

  wishlistItems() async {
    String jwt = await _storage.readData('jwt');
    payload = await _storage.getTokenClaims(jwt);
    List<WishList> list = await this._db.getWishListItems(payload['uid']);
    setState(() {
      wishlist = list;
    });
  }

  @override
  void initState() {
    this._db = SqliteDB();
    //WishList.wishlist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: WishList.wishlist.length == 0
                ? Center(
                    child: Container(
                      child: Text('You don\'t have any favorite book, add one'),
                    ),
                  )
                : ListView.builder(
                    itemCount: WishList.wishlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: WishListItemCard(
                          wishList: WishList.wishlist[index],
                        ),
                      );
                    })));
  }
}
