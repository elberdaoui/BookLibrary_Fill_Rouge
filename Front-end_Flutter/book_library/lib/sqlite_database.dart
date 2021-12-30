import 'dart:io';

import 'package:book_library/models/Order.dart';
import 'package:book_library/models/WishList.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/Cart.dart';

class SqliteDB {
  late final database;
  Future<Database> openDB() async {
    // Directory pathh;
    return openDatabase(
      join(await getDatabasesPath(), 'cartOrderWishlist.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE carts(id INTEGER PRIMARY KEY AUTOINCREMENT, uid TEXT, bookId TEXT, bookName TEXT, numOfitems INTEGER, photo TEXT, price REAL)',
        );
        await db.execute(
          'CREATE TABLE orders(id INTEGER PRIMARY KEY AUTOINCREMENT, uid TEXT, bookId TEXT, bookName TEXT, numOfitems INTEGER, photo TEXT, price REAL)',
        );
        await db.execute(
          'CREATE TABLE wishlist(id INTEGER PRIMARY KEY AUTOINCREMENT, uid TEXT, bookId TEXT, bookName TEXT, photo TEXT, price REAL, isFav BOOLEAN NOT NULL CHECK(isFav IN (0,1)))',
        );
      },
      version: 1,
    );
  }

  // Future<void> insertItems(List<Cart> cart) async {
  //   final Database db = await openDB();
  //   for (var carts in cart) {
  //     await db.insert('carts', carts.toMap());
  //   }
  // }

  // ======== CRUD for Cart ========  ""beginning""//
  Future<void> insertItems(Cart cart) async {
    final Database db = await openDB();
    await db.insert('carts', cart.toMap());
  }

  Future<void> updateItems({required int? id, required Cart cart}) async {
    final Database db = await openDB();
    await db.update('carts', cart.toMap(), where: "id = ?", whereArgs: [id]);
  }

  // Future<List<Cart>> getItems() async {
  //   final Database db = await openDB();
  //   final List<Map<String, Object?>> queryResult = await db.query('carts');
  //   return queryResult.map((e) => Cart.fromMap(e)).toList();
  // }
  Future<List<Cart>> getItems(String uid) async {
    final Database db = await openDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('carts', where: "uid = ?", whereArgs: [uid]);
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<void> deleteItem(int id) async {
    final db = await openDB();
    await db.delete(
      'carts',
      where: "id = ?",
      whereArgs: [id],
    );
  }
  // ======== CRUD for Cart ========  ""end""//

  // ======== CRUD for Order ========  ""beginning""//

  Future<List<Order>> getItemsOrder(String uid) async {
    final Database db = await openDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('orders', where: "uid = ?", whereArgs: [uid]);
    return queryResult.map((e) => Order.fromMap(e)).toList();
  }

  Future<void> insertItemsOrder(Cart cart) async {
    final Database db = await openDB();
    await db.insert('orders', cart.toMap());
  }

  // ======== CRUD for Order ========  ""end""//

  // ======== CRUD for wishlist ========  ""beginning""//
  Future<List<WishList>> getWishListItems(String uid) async {
    final Database db = await openDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('wishlist', where: "uid = ?", whereArgs: [uid]);
    return queryResult.map((e) => WishList.fromMap(e)).toList();
  }

  Future<void> insertWishlistItems(WishList wishlist) async {
    final Database db = await openDB();
    await db.insert('wishlist', wishlist.toMap());
  }

  Future<void> updateWishlistItems(
      {int? id, required WishList wishList}) async {
    final Database db = await openDB();
    await db
        .update('wishlist', wishList.toMap(), where: "id = ?", whereArgs: [id]);
  }
  // ======== CRUD for wishlist ========  ""end""//

  double get totalAmount {
    double amount = 0;
    for (var prices in booksList) {
      amount = amount + prices.price;
    }
    return amount;
  }
}
