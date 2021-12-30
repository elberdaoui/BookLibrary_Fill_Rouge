// import 'package:book_library/models/Products.dart';
import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:book_library/services/storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../sqlite_database.dart';
import 'cart_item_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late SqliteDB dbHandler;
  late List<Cart> cartItems;
  late Map<String, dynamic> payload;
  SecureStorage _storage = SecureStorage();
  // late List docs;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  // Future<List> getData() async {
  //   QuerySnapshot querySnapshot;
  //   List documents = [];
  //   querySnapshot = await firestore.collection('carts').get();
  //   try {
  //     if (querySnapshot.docs.isNotEmpty) {
  //       for (var doc in querySnapshot.docs.toList()) {
  //         documents.add(doc);
  //       }
  //       return documents;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return documents;
  // }

  // Future<List<Cart>> getCartLength() async {
  //   cartsList = await this.dbHandler.getItems();
  //   return cartsList;
  // }

  @override
  void initState() {
    this.dbHandler = SqliteDB();
    // getCartLength();
    // getTokenClaims();
    // cartItems = this.dbHandler.getItems() as List<Cart>;
    // print(cartItems.toList());

    totalAmount;
    // getData().then((value) => {
    //       setState(() {
    //         docs = value;
    //       })
    //     });
    super.initState();
  }

  // getTokenClaims() async {
  //   String jwt = await _storage.readData('jwt');
  //   setState(() {
  //     payload = json.decode(
  //         utf8.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
  //     print(payload);
  //   });
  // }

  // getCartLength() async {
  //   String jwt = await _storage.readData('jwt');
  //   Map<String, dynamic> payload = await _storage.getTokenClaims(jwt);
  //   cartItems = await this.dbHandler.getItems(payload['uid']);
  //
  //   setState(() {
  //     cartsList = cartItems;
  //   });
  //   // return cartsList;
  // }

  @override
  Widget build(BuildContext context) {
    double sum = 0;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: cartsList.length == 0
          ? Center(
              child: Container(
                child: Text('Choose your favorite books'),
              ),
            )
          : ListView.builder(
              // itemCount: booksList == null ? 0 : booksList.length,
              itemCount: cartsList.length,
              // itemCount: docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    // key: Key(demoCart[index].books.id.toString()),
                    key: Key(cartsList[index].id.toString()),
                    // key: Key(docs[index]['id'].toString()),
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
                      await this.dbHandler.deleteItem(cartsList[index].id!);
                      setState(() {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) => super.widget));
                        cartsList.removeAt(index);
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
                      cart: cartsList[index],
                      // book: docs[index],
                    ),
                  ),
                );
              }),
      // child: FutureBuilder(
      //   future: this.dbHandler.getItems(),
      //   builder: (BuildContext context, AsyncSnapshot<List<Cart>> snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //           // itemCount: booksList == null ? 0 : booksList.length,
      //           itemCount: snapshot.data!.length,
      //           // itemCount: docs.length,
      //           itemBuilder: (context, index) {
      //             return Padding(
      //               padding: EdgeInsets.symmetric(vertical: 10),
      //               child: Dismissible(
      //                 direction: DismissDirection.endToStart,
      //                 // key: Key(demoCart[index].books.id.toString()),
      //                 // key: Key(booksList[index].id.toString()),
      //                 // key: Key(snapshot.data![index].id!),
      //                 key: Key(snapshot.data![index].id.toString()),
      //                 onDismissed: (direction) async {
      //                   // await this
      //                   //     .dbHandler
      //                   //     .deleteItem(snapshot.data![index].id!);
      //                   // await this
      //                   //     .dbHandler
      //                   //     .deleteItem(snapshot.data![index].id);
      //                   await this
      //                       .dbHandler
      //                       .deleteItem(snapshot.data![index].id!);
      //                   setState(() {
      //                     // booksList.removeAt(index);
      //                     snapshot.data!.removeAt(index);
      //                     totalAmount;
      //                     print(totalAmount);
      //                     // print(booksList.toString());
      //                   });
      //                   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                   //   duration: Duration(seconds: 3),
      //                   //   action: SnackBarAction(
      //                   //     label:
      //                   //         '${snapshot.data![index].bookName} will be deleted',
      //                   //     onPressed: () {},
      //                   //   ),
      //                   //   content: Text(
      //                   //       '${snapshot.data![index].bookName} added to cart'),
      //                   // ));
      //                   // SharedPreferences pref =
      //                   //     await SharedPreferences.getInstance();
      //                   // pref.setString('book_key', Book.encode(booksList));
      //                 },
      //                 // key: Key(docs[index]['id'].toString()),
      //                 background: Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 20),
      //                   decoration: BoxDecoration(
      //                       color: Color(0xFFFFE6E6),
      //                       borderRadius: BorderRadius.circular(15)),
      //                   child: Row(
      //                     children: [
      //                       Spacer(),
      //                       SvgPicture.asset('assets/icons/Trash.svg')
      //                     ],
      //                   ),
      //                 ),
      //
      //                 child: CartItemCard(
      //                   // cart: demoCart[index],
      //                   // book: booksList[index],
      //                   // book: docs[index],
      //                   // book: snapshot.data![index],
      //                   cart: snapshot.data![index],
      //                 ),
      //               ),
      //             );
      //           });
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );
  }
}
