import 'package:book_library/screens/managing_books/add_book/components/body.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatelessWidget {
  static String routeName = '/add';
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add book'),
      ),
      body: Body(),
    );
  }
}
