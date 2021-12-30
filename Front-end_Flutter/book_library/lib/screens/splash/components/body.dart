import 'dart:async';
import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/models/WishList.dart';
import 'package:book_library/screens/home/home_screen.dart';
import 'package:book_library/screens/managing_books/manage_screen.dart';
import 'package:book_library/services/api_book_library.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/screens/splash/components/splash_content.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/screens/sign_in/sign_in_screen.dart';
import 'package:book_library/size_config.dart';

import '../../../sqlite_database.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  late List<Book> books = [];
  late SqliteDB _db;
  SecureStorage _storage = SecureStorage();
  List<Map<String, String>> splashData = [
    {'text': 'Welcome to SMART LIBRARY', 'image': 'assets/images/splash_1.png'},
    {'text': 'Enjoy reading and buying', 'image': 'assets/images/splash_2.png'},
    {'text': 'Thank you', 'image': 'assets/images/splash_3.png'}
  ];

  getBooks() {
    ApiBookService.getBooks().then((value) {
      List<dynamic> listOfBooks = <dynamic>[];
      listOfBooks = json.decode(value.body);
      setState(() {
        if (listOfBooks.length > 0) {
          for (int i = 0; i < listOfBooks.length; i++) {
            if (listOfBooks[i] != null) {
              Map<String, dynamic> mapp = listOfBooks[i];
              books.add(Book.fromObject(mapp));
              // filteredBooks = books;
              booksList = books;
              // print('filtered books: $booksList');
            }
          }
        }
      });
    });
  }

  wishlistItems() async {
    String jwt = await _storage.readData('jwt');
    Map<String, dynamic> wishlistPayload = {};
    if (jwt == null) {
      return;
    } else {
      wishlistPayload = await _storage.getTokenClaims(jwt);
    }

    List<WishList> list =
        await this._db.getWishListItems(wishlistPayload['uid']);
    setState(() {
      WishList.wishlist = list;
    });
  }

  // @override
  // void initState() {
  //   ApiBookService.getBooks().then((value) {
  //     Iterable list = json.decode(value.body);
  //     List<Book> listOfBooks = <Book>[];
  //     listOfBooks = list.map((e) => Book.fromObject(e)).toList();
  //     setState(() {
  //       booksList = listOfBooks;
  //       // booksList.add(listOfBooks.first);
  //       print('splash');
  //       // booksList = books;
  //     });
  //   });
  //
  //   super.initState();
  // }
  @override
  void initState() {
    // keepUserLoggedIn();
    this._db = SqliteDB();
    getBooks();
    wishlistItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: SafeArea(
              child: SizedBox(
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      text: splashData[index]['text'],
                      image: splashData[index]['image'],
                    ),
                  )),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  DefaultButton(
                    text: 'Continue',
                    press: () {
                      // Navigator.pushNamed(context, SignInScreen.routeName);
                      keepUserLoggedIn();
                    },
                  ),
                  Spacer(),
                ],
              ),
            ))
      ],
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      width: currentPage == index ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  void keepUserLoggedIn() async {
    String jwt = await _storage.readData('jwt');

    if (jwt == null) {
      Timer(Duration(seconds: 2),
          () => Navigator.pushNamed(context, SignInScreen.routeName));
    } else {
      Map<String, dynamic> payload = await _storage.getTokenClaims(jwt);
      Timer(
          Duration(seconds: 2),
          () => payload['roles'] == 'Admin'
              ? Navigator.pushNamed(context, ManageScreen.routeName)
              : Navigator.pushNamed(context, HomeScreen.routeName));
    }
  }
}
