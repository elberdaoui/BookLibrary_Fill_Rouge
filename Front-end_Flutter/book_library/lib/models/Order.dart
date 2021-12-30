import 'package:flutter/material.dart';

class Order {
  late int? id;
  late String uid;
  late String bookId;
  late String bookName;
  late String photo;
  late double price;
  late int numOfitems;
  Order(
    this.id,
    this.bookId,
    this.uid,
    this.bookName,
    this.price,
    this.photo,
    this.numOfitems,
  );

  Order.fromMap(Map<String, dynamic> res) {
    this.id = res['id'];
    this.bookId = res['bookId'];
    this.bookName = res['bookName'];
    this.photo = res['photo'].toString();
    this.price = res['price'];
    this.numOfitems = res['numOfitems'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'bookId': bookId,
      'bookName': bookName,
      'photo': photo,
      'price': price,
      'numOfitems': numOfitems,
    };
  }
}
