import 'package:book_library/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/product_card_1.dart';
import 'package:book_library/models/Products.dart';
import 'package:book_library/screens/details/details_screen.dart';
import 'package:book_library/screens/home/components/section_title.dart';

import '../../../size_config.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(text: 'Popular Products', press: () {}),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
          child: Row(
            children: [
              // ListView.builder(
              //     itemCount: bookDemo.length,
              //     itemBuilder: (context, index) => ProductCard(
              //           // product: booksList[index],
              //           // product: booksList[index] == null
              //           //     ? bookDemo[index]
              //           //     : booksList[index],
              //           product: bookDemo[index],
              //           press: () {
              //             Navigator.pushNamed(context, DetailsScreen.routeName,
              //                 arguments: ProductDetailsArguments(
              //                     book: bookDemo[index]));
              //           },
              //         )),
              ...List.generate(
                // demoProducts.length,
                // booksList.length == 0 ? bookDemo.length : booksList.length,
                booksList.length,
                (index) {
                  // if (demoProducts[index].isPopular) {
                  return ProductCard(
                    // product: booksList[index],
                    // product: booksList[index] == null
                    //     ? bookDemo[index]
                    //     : booksList[index],
                    product: booksList[index],
                    press: () {
                      Navigator.pushNamed(context, DetailsScreen.routeName,
                          arguments:
                              ProductDetailsArguments(book: booksList[index]));
                    },
                  );
                  // }

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              )
            ],
          ),
        ),
      ],
    );
  }
}
