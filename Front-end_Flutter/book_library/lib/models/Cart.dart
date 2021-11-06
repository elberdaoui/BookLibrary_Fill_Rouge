import 'package:book_library/models/Book.dart';
import 'package:book_library/services/storage.dart';

import '../sqlite_database.dart';
// import 'package:book_library/models/Products.dart';

class Cart {
  // final Book? books;
  late int? id;
  late String uid;
  late String bookId;
  late String bookName;
  late String photo;
  late double price;
  late int numOfitems;
  List<Book> bookss = [];
  // SecureStorage _storage = SecureStorage();
  Cart(
      {this.id,
      required this.uid,
      required this.bookId,
      required this.bookName,
      required this.photo,
      required this.price,
      // this.books,
      required this.numOfitems});
  // late String _id;
  // late String _bookName;
  // late String _photo;
  // late double _price;
  // late int _numOfitems;
  // List<Book> bookss = [];

  // Cart(
  //     this._id,
  //     this._bookName,
  //     this._photo,
  //     this._price,
  //     // this.books,
  //     this._numOfitems);

  // String get id => _id;
  // String get bookName => _bookName;
  // String get photo => _photo;
  // double get price => _price;
  // int get numOfitems => _numOfitems;
  //
  // set newBookName(String name) => _bookName = name;
  // set newBookPhoto(String photo) => _photo = photo;
  // set newBookPrice(double price) => _price = price;
  // set newNumOfitems(int numOfitems) => _numOfitems = numOfitems;

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'uid': uid.toString(),
      'bookId': bookId,
      'bookName': bookName,
      'photo': photo,
      'price': price.toString(),
      'numOfitems': numOfitems.toString(),
    };
  }

  // Cart.fromMap(Map<String, dynamic> res) {
  //   this._id = res['id'];
  //   this._bookName = res['bookName'];
  //   this._photo = res['photo'].toString();
  //   this._price = res['price'];
  //   this._numOfitems = res['numOfitems'];
  // }

  Cart.fromMap(Map<String, dynamic> res) {
    this.id = res['id'];
    this.uid = res['uid'];
    this.bookId = res['bookId'];
    this.bookName = res['bookName'];
    this.photo = res['photo'].toString();
    this.price = res['price'];
    this.numOfitems = res['numOfitems'];
  }

  @override
  String toString() {
    return 'Cart{id: $id, bookId: $bookId, bookName: $bookName, photo: $photo, price: $price, numOfitems: $numOfitems}';
  }

  // double get total {
  //   return booksList.fold(0.0,
  //       (double currentAmount, Book getBooks) => currentAmount + books!.price);
  // }
  // static double get totalAmount {
  //   double amount = 0;
  //   for (var prices in cartsList) {
  //     amount = amount + prices.price * prices.numOfitems;
  //   }
  //   return amount;
  // }
}

//demo cart

// List<Cart> demoCart = [
//   Cart(books: demoProducts[0], numOfitems: 2),
//   Cart(books: demoProducts[1], numOfitems: 1),
//   Cart(books: demoProducts[3], numOfitems: 1),
// ];

List<Book> booksList = [];
List<Cart> cartsList = [];

// List<Book> bookDemo = [
//   Book(
//     "bookName",
//     "description",
//     22,
//     DateTime.now(),
//     false,
//     0
//   ),
//   Book(
//     "bookName",
//     "description",
//     2,
//     DateTime.now(),
//     false,
//     0
//   ),
//   Book(
//     "bookName",
//     "description",
//     25,
//     DateTime.now(),
//     false,
//     0
//   )
// ];

// var totalPrice = booksList.forEach((element) => 0 + element.price);
// Future<List<Cart>> getCartLength() async {
//   SqliteDB dbHandler = SqliteDB();
//   cartsList = await dbHandler.getItems();
//   return cartsList;
// }

List<Book> filteredBooks = [];

int get totalAmount {
  int amount = 0;
  for (var prices in cartsList) {
    amount = amount + prices.price.floor() * prices.numOfitems;
    // amount = amount + prices.price.floor();
  }
  return amount;
}
