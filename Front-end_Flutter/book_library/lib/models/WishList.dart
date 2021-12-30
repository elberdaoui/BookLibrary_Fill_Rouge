class WishList {
  late int? id;
  late String uid;
  late String bookId;
  late String bookName;
  late String photo;
  late double price;
  late bool isFav;
  static List<WishList> wishlist = [];
  WishList({
    this.id,
    required this.uid,
    required this.bookId,
    required this.bookName,
    required this.photo,
    required this.price,
    required this.isFav,
  });

  WishList.fromMap(Map<String, dynamic> res) {
    this.id = res['id'];
    this.bookId = res['bookId'];
    this.bookName = res['bookName'];
    this.photo = res['photo'].toString();
    this.price = res['price'];
    this.isFav = res['isFav'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'bookId': bookId,
      'bookName': bookName,
      'photo': photo,
      'price': price,
      'isFav': isFav,
    };
  }
}
