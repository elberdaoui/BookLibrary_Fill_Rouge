import 'dart:convert';

import 'package:book_library/models/Book.dart';
import 'package:http/http.dart' as http;

class BookLibService {
  // static String baseUrl = 'http://10.0.0.12:5000/api'; // url for phone device
  // static String baseUrl =
  //     'http://192.168.1.104:5000/api'; // url for phone device on 2nd router
  static String baseUrl = 'http://10.0.2.2:5000/api'; // url for emulator
  static String authorUrl = '${BookLibService.baseUrl}/Authors/';
  static String userUrl = '${BookLibService.baseUrl}/User/';
  static String categoryUrl = '${BookLibService.baseUrl}/Categories/';
  static String bookUrl = '${BookLibService.baseUrl}/Books/';
  static String registerUrl = '${BookLibService.baseUrl}/Auth/Register';
  static String loginUrl = '${BookLibService.baseUrl}/Auth/Login';
  static String rollAssignUrl = '${BookLibService.baseUrl}/Auth/AssigningUsers';
}

class ApiBookService {
  static Future<List<Book>> getAllBooks() async {
    final response =
        await http.get(Uri.parse('${BookLibService.bookUrl}/Books'));
    if (response.statusCode == 200) {
      List<dynamic> list = <dynamic>[];
      // var base64 = Base64Encoder().convert(response.bodyBytes);
      list = json.decode(response.body);
      if (list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i] != null) {
            Map<String, dynamic> mapp = list[i];
          }
        }
      }
      return Future.value(json.decode(response.body));

      // return base64;
    } else {
      return null as dynamic;
    }
  }

  static String encode(List<Book> books) => json.encode(
        books.map<Map<String, dynamic>>((book) => Book.toMappp(book)).toList(),
      );

  static List<Book> decode(String books) =>
      (json.decode(books) as List<dynamic>)
          .map<Book>((item) => Book.fromObject(item))
          .toList();

  // static Future getBooks() async {
  //   final response =
  //       await http.get(Uri.parse('${BookLibService.bookUrl}/Books'));
  //   if (response.statusCode == 200) {
  //     var base64 = Base64Encoder().convert(response.bodyBytes);
  //     // return Future.value(json.decode(response.body));
  //     // return base64;
  //     return Future.value(base64);
  //   } else {
  //     return null as dynamic;
  //   }
  // }
  static Future getBooks() async {
    print('work');
    // return await http.get(Uri.parse('${BookLibService.bookUrl}Books'));
    return await http.get(Uri.parse('${BookLibService.bookUrl}Books'));
  }

  static Future<bool> addBook(body) async {
    final response = await http
        .post(Uri.parse('${BookLibService.bookUrl}CreateBook'), body: body);
    if (response.statusCode == 200) {
      print('work');
      return true;
    } else {
      print('not work');
      return false;
    }
  }
}
