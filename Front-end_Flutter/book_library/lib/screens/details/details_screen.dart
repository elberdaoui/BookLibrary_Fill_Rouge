import 'package:book_library/models/Book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_library/components/rounded_icn_btn.dart';
// import 'package:book_library/models/Products.dart';
import 'package:book_library/screens/details/components/body.dart';
import 'package:book_library/size_config.dart';

import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = '/details';
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(
        rating: args.book.rating,
      ),
      body: Body(
        book: args.book,
      ),
    );
  }
}

class ProductDetailsArguments {
  final Book book;

  ProductDetailsArguments({required this.book});
}
