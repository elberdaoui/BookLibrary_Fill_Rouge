import 'package:book_library/models/Book.dart';
// import 'package:book_library/models/Products.dart';

class Cart {
  final Book? books;
  final int? numOfitems;
  List<Book> bookss = [];

  Cart({this.books, this.numOfitems});

  double get total {
    return booksList.fold(0.0,
        (double currentAmount, Book getBooks) => currentAmount + books!.price);
  }
}

//demo cart

// List<Cart> demoCart = [
//   Cart(books: demoProducts[0], numOfitems: 2),
//   Cart(books: demoProducts[1], numOfitems: 1),
//   Cart(books: demoProducts[3], numOfitems: 1),
// ];

List<Book> booksList = [];

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

double get totalAmount {
  double amount = 0;
  for (var prices in booksList) {
    amount = amount + prices.price;
  }
  return amount;
}
