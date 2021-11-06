import 'dart:async';
import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/screens/home/home_screen.dart';
import 'package:book_library/services/api_book_library.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/screens/splash/components/splash_content.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/screens/sign_in/sign_in_screen.dart';
import 'package:book_library/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  SecureStorage _storage = SecureStorage();
  List<Map<String, String>> splashData = [
    {'text': 'Welcome to SMART LIBRARY', 'image': 'assets/images/splash_1.png'},
    {'text': 'Enjoy reading and buying', 'image': 'assets/images/splash_2.png'},
    {'text': 'Thank you', 'image': 'assets/images/splash_3.png'}
  ];
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
      Timer(Duration(seconds: 2),
          () => Navigator.pushNamed(context, HomeScreen.routeName));
    }
  }
}
