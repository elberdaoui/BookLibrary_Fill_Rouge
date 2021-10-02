import 'dart:convert';
import 'dart:typed_data';

import 'package:book_library/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Book {
  late String _id;
  late String _bookNm;
  late String _description;
  late double _price;
  // late ByteBuffer? _photo;
  late String _photo;
  // late List<Category>? _categories;
  late DateTime _publishedDate;
  late bool _isFav;
  late int _rating;

  Book(
      this._bookNm,
      this._description,
      this._price,
      this._photo,
      // this._categories,
      this._publishedDate,
      this._isFav,
      this._rating);
  Book.WithId(
      this._id,
      this._bookNm,
      this._description,
      this._price,
      this._photo,
      // this._categories,
      this._publishedDate,
      this._isFav,
      this._rating);

  Book.fromObject(dynamic obj) {
    this._id = obj['id'];
    this.newBookName = obj['bookName'];
    this.newDescription = obj['description'];
    this.newPrice = obj['price'];
    this.newPublishedDate = DateTime.parse(obj['publishedDate']);
    this.newIsFav = obj['isFav'];
    this.newPhoto = obj['photoCover'];
    this.newRating = obj['rating'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['bookName'] = _bookNm;
    map['description'] = _description;
    map['price'] = _price;
    map['photoCover'] = _photo;
    map['publishedDate'] = _publishedDate;
    map['isFav'] = _isFav;
    map['rating'] = _rating;
    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }

  static Map<String, dynamic> toMappp(Book book) => {
        'id': book.id,
        'bookName': book.bookName,
        'rating': book.rating,
        'description': book.description,
        'price': book.price,
        'photoCover': book.photo,
        'publishedDate': book.publishedDate.toString(),
        'isFav': book.isFav,
      };

  // static List<Map<String, dynamic>> toListMappp(List<Book> book) => {
  //   'id': book.id
  //   'bookName': book.bookName,
  //   'rating': book.rating,
  //   'description': book.description,
  //   'price': book.price,
  //   'photoCover': book.photo,
  //   'publishedDate': book.publishedDate.toString(),
  //   'isFav': book.isFav,
  // };

  static String encode(List<Book> books) => json.encode(
        books.map<Map<String, dynamic>>((book) => Book.toMappp(book)).toList(),
      );

  static List<Book> decode(String books) =>
      (json.decode(books) as List<dynamic>)
          .map<Book>((item) => Book.fromObject(item))
          .toList();

  String get id => _id;
  String get bookName => _bookNm;
  String get description => _description;
  double get price => _price;
  String get photo => _photo;
  // List<Category>? get categories => _categories;
  DateTime get publishedDate => _publishedDate;
  bool get isFav => _isFav;
  int get rating => _rating;

  set newBookName(String name) {
    _bookNm = name;
  }

  set newDescription(String newDescription) {
    _description = newDescription;
  }

  set newPrice(double newPrice) {
    _price = newPrice;
  }

  set newPhoto(String newPhoto) {
    _photo = newPhoto;
  }

  set newPublishedDate(DateTime newPublishedDate) {
    _publishedDate = newPublishedDate;
  }

  set newIsFav(bool isFav) {
    _isFav = isFav;
  }

  set newRating(int rating) {
    _rating = rating;
  }

  static String byteConvert(Uint8List input) {
    String base64 = '';
    return base64Encode(input);
    // base64 = Base64Encoder().convert(input);
    // return Base64Codec().decode(base64);
  }
}
