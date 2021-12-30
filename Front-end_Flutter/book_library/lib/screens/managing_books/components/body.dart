import 'package:book_library/components/product_card_1.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/screens/details/details_screen.dart';
import 'package:book_library/screens/managing_books/edit_book/edit_book_screen.dart';
import 'package:book_library/services/api_book_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: booksList.length,
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) {
    //       return Dismissible(
    //         // direction: DismissDirection.endToStart,
    //         key: Key(booksList[index].id.toString()),
    //         background: Container(
    //           alignment: Alignment.centerLeft,
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           decoration: BoxDecoration(
    //               color: Color(0xFF87ecab),
    //               borderRadius: BorderRadius.circular(15)),
    //           child: SvgPicture.asset(
    //             'assets/icons/edit1.svg',
    //             color: Colors.green.shade800,
    //             width: 50,
    //           ),
    //         ),
    //         secondaryBackground: Container(
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           decoration: BoxDecoration(
    //               color: Color(0xFFFFE6E6),
    //               borderRadius: BorderRadius.circular(15)),
    //           child: Row(
    //             children: [
    //               Spacer(),
    //               SvgPicture.asset(
    //                 'assets/icons/Trash.svg',
    //                 width: 50,
    //               ),
    //             ],
    //           ),
    //         ),
    //         onDismissed: (direction) {
    //           switch (direction) {
    //             case DismissDirection.startToEnd:
    //               Navigator.pushNamed(context, EditBookScreen.routeName);
    //               print('updated');
    //               break;
    //             case DismissDirection.endToStart:
    //               print('deleted');
    //               break;
    //           }
    //         },
    //         child: ProductCard(
    //             product: booksList[index],
    //             press: () {
    //               Navigator.pushNamed(context, DetailsScreen.routeName,
    //                   arguments:
    //                       ProductDetailsArguments(book: booksList[index]));
    //
    //               // AlertDialog(
    //               //   title: Text('Actions'),
    //               //   actions: [
    //               //     TextButton(
    //               //         onPressed: () => Navigator.pushNamed(
    //               //             context, DetailsScreen.routeName,
    //               //             arguments:
    //               //                 ProductDetailsArguments(book: booksList[index])),
    //               //         child: Text('Details')),
    //               //     TextButton(
    //               //         onPressed: () => Navigator.pushNamed(
    //               //             context, DetailsScreen.routeName,
    //               //             arguments:
    //               //                 ProductDetailsArguments(book: booksList[index])),
    //               //         child: Text('Edit')),
    //               //     TextButton(
    //               //         onPressed: () => Navigator.pushNamed(
    //               //             context, DetailsScreen.routeName,
    //               //             arguments:
    //               //                 ProductDetailsArguments(book: booksList[index])),
    //               //         child: Text('Delete')),
    //               //   ],
    //               //   // shape: CircleBorder(side: BorderSide),
    //               // );
    //             }),
    //       );
    //     });
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        booksList;
      },
      displacement: 100.0,
      color: Colors.white,
      backgroundColor: kPrimaryColor,
      child: ListView.builder(
          itemCount: booksList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              // actionExtentRatio: 0.25,
              actions: [
                IconSlideAction(
                  caption: 'Update',
                  icon: Icons.edit,
                  color: Color(0xFF87ecab),
                  foregroundColor: Colors.green.shade900,
                  onTap: () {
                    Navigator.pushNamed(context, EditBookScreen.routeName,
                        arguments:
                            ProductDetailsArguments(book: booksList[index]));
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  icon: Icons.delete_forever,
                  foregroundColor: Colors.red,
                  color: Color(0xFFFFE6E6),
                  onTap: () {
                    ApiBookService.deleteBook(booksList[index].id)
                        .then((response) {
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('deleted successfully'),
                        ));
                      }
                    });
                    setState(() {
                      booksList.removeAt(index);
                    });
                  },
                ),
              ],
              child: ProductCard(
                  product: booksList[index],
                  press: () {
                    Navigator.pushNamed(context, DetailsScreen.routeName,
                        arguments:
                            ProductDetailsArguments(book: booksList[index]));

                    // AlertDialog(
                    //   title: Text('Actions'),
                    //   actions: [
                    //     TextButton(
                    //         onPressed: () => Navigator.pushNamed(
                    //             context, DetailsScreen.routeName,
                    //             arguments:
                    //                 ProductDetailsArguments(book: booksList[index])),
                    //         child: Text('Details')),
                    //     TextButton(
                    //         onPressed: () => Navigator.pushNamed(
                    //             context, DetailsScreen.routeName,
                    //             arguments:
                    //                 ProductDetailsArguments(book: booksList[index])),
                    //         child: Text('Edit')),
                    //     TextButton(
                    //         onPressed: () => Navigator.pushNamed(
                    //             context, DetailsScreen.routeName,
                    //             arguments:
                    //                 ProductDetailsArguments(book: booksList[index])),
                    //         child: Text('Delete')),
                    //   ],
                    //   // shape: CircleBorder(side: BorderSide),
                    // );
                  }),
            );
          }),
    );
  }

  AlertDialog getAlertDialog() {
    return AlertDialog(
      title: Text('actions'),
      actions: [
        TextButton(onPressed: () => Navigator.pop, child: Text('Close')),
      ],
    );
  }
}
