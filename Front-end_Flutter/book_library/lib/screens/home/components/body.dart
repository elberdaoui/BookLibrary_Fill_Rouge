import 'dart:async';
import 'dart:convert';
import 'dart:core';

// import 'package:book_library/components/product_card.dart';
import 'package:book_library/components/product_card_1.dart';
import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/models/WishList.dart';
import 'package:book_library/screens/details/details_screen.dart';
import 'package:book_library/services/api_book_library.dart';
import 'package:flutter/material.dart';
// import 'package:book_library/models/Products.dart';
import 'package:book_library/screens/home/components/home_header.dart';
import 'package:book_library/screens/home/components/special_offers.dart';
import 'package:book_library/size_config.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'popular_products.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Book> books = [];
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

      // listOfBooks = list.map((e) => Book.fromObject(e)).toList();
      // setState(() {
      //   // books = listOfBooks;
      //   books.add(listOfBooks.first);
      //   print(books.toList());
      //   // booksList = books;
      // });
    });
  }

  @override
  void initState() {
    // ApiBookService.getBooks().then((value) {
    //   Iterable list = json.decode(value.body);
    //   List<Book> listOfBooks = <Book>[];
    //   listOfBooks = list.map((e) => Book.fromObject(e)).toList();
    //   setState(() {
    //     books = listOfBooks;
    //     // books.add(listOfBooks.first);
    //     print(books.toList());
    //     // booksList = books;
    //   });
    // });
    getBooks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Book>> futureBooks() async {
    //   Future<List<Book>> listBooks = await ApiBookService.getBooks() as Future<List<Book>>;
    //   setState(() {
    //     //ApiBookService.getBooks().then((value) => books = ApiBookService.)
    //     // books = listBooks.map((e) => Book.fromObject(e)).toList();
    //     books = await listBooks;
    //     return books;
    //   });
    // }
    // Future<List<Book>> listBooks = ApiBookService.getBooks() as Future<List<Book>>;
    // setState(() async {
    //   //ApiBookService.getBooks().then((value) => books = ApiBookService.)
    //   // books = listBooks.map((e) => Book.fromObject(e)).toList();
    //   books = await listBooks;
    //   return books;
    // });
    // List<Book> listBooks = ApiBookService.getBooks() as List<Book>;
    // setState(() {
    //   books = listBooks.map((e) => Book.fromObject(e)).toList();
    //   //ApiBookService.getBooks().then((value) => books = ApiBookService.)
    // });

    return SafeArea(
        child: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        HomeHeader(),
        SizedBox(height: getProportionateScreenHeight(30)),
        DiscountBanner(),
        SizedBox(height: getProportionateScreenHeight(30)),
        Categories(),
        SizedBox(height: getProportionateScreenHeight(30)),
        // SpecialOffers(),
        // SizedBox(height: getProportionateScreenHeight(30)),
        // PopularProducts(),
        // SizedBox(height: getProportionateScreenHeight(30)),
        // FutureBuilder<List<Book>>(future: , builder: (context, snapshot){
        //   if(snapshot.hasData){
        //     return ListView.builder(
        //         itemCount: books.length,
        //         itemBuilder: (context, index) => ProductCard(
        //           product: books[index],
        //           press: () {
        //             Navigator.pushNamed(context, DetailsScreen.routeName);
        //           },
        //         ));
        //   }
        // }),
        // ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     shrinkWrap: true,
        //     itemCount: books.length,
        //     itemBuilder: (context, index) => ProductCard(
        //           product: books[index],
        //           press: () {
        //             Navigator.pushNamed(context, DetailsScreen.routeName);
        //           },
        //         )),

        ...List.generate(
          books.length,
          (index) => WishList.wishlist.length != 0
              ? ProductCard(
                  product: books[index],
                  wishList: WishList.wishlist[index],
                  press: () {
                    Navigator.pushNamed(context, DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(book: books[index]));
                  },
                )
              : ProductCard(
                  product: books[index],
                  press: () {
                    Navigator.pushNamed(context, DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(book: books[index]));
                  },
                ),
        ),
        //  filteredBooks.length != 0 ?
        // ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     shrinkWrap: true,
        //     itemCount: books.length,
        //     itemBuilder: (context, index) => ProductCard(
        //         product: books[index],
        //         press: () {
        //           Navigator.pushNamed(context, DetailsScreen.routeName,
        //               arguments: ProductDetailsArguments(book: books[index]));
        //         }))
        // : ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     shrinkWrap: true,
        //     itemCount: filteredBooks.length,
        //     itemBuilder: (context, index) => ProductCard(
        //           key: ValueKey(filteredBooks[index].id.toString()),
        //           product: filteredBooks[index],
        //           press: () {
        //             Navigator.pushNamed(context, DetailsScreen.routeName,
        //                 arguments:
        //                     ProductDetailsArguments(book: books[index]));
        //           },
        //         ))
      ],
    )));
  }
}
