import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Cart.dart';
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
    List<Book> filteredKeys = [];
    if (keyword.isEmpty) {
      filteredKeys = booksList;
    } else {
      filteredKeys = booksList
          .where((element) =>
              element.bookName.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredBooks = filteredKeys;
    });
  }
}
