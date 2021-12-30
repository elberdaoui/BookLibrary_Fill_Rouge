import 'package:book_library/screens/managing_books/edit_book/components/body.dart';
import 'package:flutter/material.dart';

class EditBookScreen extends StatelessWidget {
  static String routeName = '/edit';
  const EditBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Body(),
    );
  }
}
