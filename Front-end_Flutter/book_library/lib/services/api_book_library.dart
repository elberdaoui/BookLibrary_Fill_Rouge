import 'dart:convert';
import 'dart:io';

import 'package:book_library/models/Book.dart';
import 'package:book_library/models/Register.dart';
import 'package:book_library/models/User.dart';
import 'package:http/http.dart' as http;

class BookLibService {
  // static String baseUrl = 'http://10.0.0.12:5000/api'; // url for phone device
  // static String baseUrl = 'http://10.0.0.9:5000/api'; // url for phone device (http)
  // static String baseUrl =
  //     'http://192.168.1.5:5000/api'; // url for phone device on 2nd router
  // static String baseUrl = 'http://10.0.2.2:5000/api'; // url for emulator

  static String baseUrl =
      'https://10.0.0.9:5001/api'; // url for phone device (https)
  static String authorUrl = '${BookLibService.baseUrl}/Authors/';
  static String userUrl = '${BookLibService.baseUrl}/User/';
  static String categoryUrl = '${BookLibService.baseUrl}/Categories/';
  static String bookUrl = '${BookLibService.baseUrl}/Books/';
  static String registerUrl = '${BookLibService.baseUrl}/Auth/Register';
  // static String loginUrl = '${BookLibService.baseUrl}/Auth/Login';
  static String authUrl = '${BookLibService.baseUrl}/Auth/';
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

  static Future addBook(String bookName, String description, double price,
      DateTime publishedDate, int quantity, File photo) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${BookLibService.bookUrl}CreateBook'));
    var pic = await http.MultipartFile.fromPath('image', photo.path);
    request.files.add(pic);
    request.fields['bookName'] = bookName;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['publishedDate'] = publishedDate.toString();
    request.fields['quantity'] = quantity.toString();
    var result = await request.send();
    return result;
  }

  static Future editBook(String id, String bookName, String description,
      double price, DateTime publishedDate, int quantity, File photo) async {
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${BookLibService.bookUrl}EditBook/$id'));
    var pic = await http.MultipartFile.fromPath('image', photo.path);
    request.files.add(pic);
    request.fields['bookName'] = bookName;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['publishedDate'] = publishedDate.toString();
    request.fields['quantity'] = quantity.toString();
    var result = await request.send();
    return result;
  }

  static Future deleteBook(String id) async {
    return await http
        .delete(Uri.parse('${BookLibService.bookUrl}DeleteBook/$id'));
  }

  static Future login(String email, String password) async {
    return await http.post(
      Uri.parse('${BookLibService.authUrl}Login'),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }

  static Future register(String email, String pass, String fName, String lName,
      String userName, String address, File photo) async {
    var req = http.MultipartRequest(
        'POST', Uri.parse('${BookLibService.authUrl}Register'));
    var pic = await http.MultipartFile.fromPath('image', photo.path);
    req.files.add(pic);
    req.fields['email'] = email;
    req.fields['password'] = pass;
    req.fields['firstName'] = fName;
    req.fields['lastName'] = lName;
    req.fields['userName'] = userName;
    req.fields['address'] = address;
    // req.files.add(await http.MultipartFile.fromBytes(
    //     'profilePhoto', photo.readAsBytesSync()));

    var res = await req.send();
    return res;
    // return await http.post(
    //   Uri.parse('${BookLibService.authUrl}Register'),
    //   headers: {'Content-Type': 'multipart/form-data'},
    //   body: json.encode({
    //     'email': email,
    //     'password': pass,
    //     'firstName': fName,
    //     'lastName': lName,
    //     'userName': userName,
    //     'address': address,
    //     'profilePhoto': photo.readAsBytesSync(),
    //     // 'phoneNumber': phone,
    //   }),
    //   encoding: Encoding.getByName("utf-8"),
    //   // headers: {'Content-Type': 'application/json; charset=UTF-8'},
    // );
  }

  // static Future register(Register register) async {
  //   return await http.post(
  //     Uri.parse('${BookLibService.authUrl}Register'),
  //     headers: {
  //       'Content-Type':
  //           'multipart/form-data, boundary=----WebKitFormBoundaryyEmKNDsBKjB7QEqu'
  //     },
  //     body: Register.toJson(register),
  //     encoding: Encoding.getByName("utf-8"),
  //     // headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //   );
  // }
}
