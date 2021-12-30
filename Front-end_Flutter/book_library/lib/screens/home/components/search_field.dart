import 'package:book_library/components/product_card_1.dart';
import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/screens/details/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController _controller = TextEditingController();
    return Container(
      width: SizeConfig.screenWidth! * 0.6,
      height: 50,
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        onChanged: (value) => _filter(value),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: 'Search book',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(15))),
      ),
    );
  }

  void _filter(String keyword) {
    Book filteredKeys;
    if (keyword.isEmpty) {
      // filteredKeys = booksList;
      filteredBooks.clear();
    } else {
      for (var fBook in booksList) {
        filteredKeys = fBook;
        if (filteredKeys.bookName
            .toLowerCase()
            .contains(keyword.toLowerCase())) {
          setState(() {
            filteredBooks.add(filteredKeys);
          });
        }
      }
      // filteredKeys = booksList
      //     .where((element) =>
      //         element.bookName.toLowerCase().contains(keyword.toLowerCase()))
      //     .toList();
    }
  }
}

class BookSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {},
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      );

  @override
  Widget buildResults(BuildContext context) => Column(
        children: [
          ...List.generate(
              booksList.length,
              (index) => ProductCard(
                  product: booksList[index],
                  press: () => Navigator.pushNamed(
                      context, DetailsScreen.routeName,
                      arguments:
                          ProductDetailsArguments(book: booksList[index]))))
        ],
        // child: ListView.builder(
        //     itemBuilder: (context, index) =>
        //         ProductCard(product: booksList[index], press: () {})),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
