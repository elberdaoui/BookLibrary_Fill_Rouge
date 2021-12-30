// import 'dart:html';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  late String? _message;
  late bool _isAuthenticated;
  late String _userName;
  late String _email;
  late String _token;
  late DateTime _expire;

  User(
    this._message,
    this._isAuthenticated,
    this._userName,
    this._email,
    this._token,
    this._expire,
  );

  // late String _id;
  // late String _message;
  // late String _firstName;
  // late String _lastName;
  // late String _address;
  // late String _photo;
  // late bool _isAuthenticated;
  // late String _userName;
  // late String _email;
  // late String _password;
  // late String _token;
  // late DateTime _expire;
  //
  // User(
  //     this._message,
  //     this._firstName,
  //     this._lastName,
  //     this._address,
  //     this._photo,
  //     this._isAuthenticated,
  //     this._userName,
  //     this._email,
  //     this._password,
  //     this._token,
  //     this._expire);
  // User.withId(
  //     this._id,
  //     this._message,
  //     this._firstName,
  //     this._lastName,
  //     this._address,
  //     this._photo,
  //     this._isAuthenticated,
  //     this._userName,
  //     this._email,
  //     this._password,
  //     this._token,
  //     this._expire);

  String? get message => _message;
  bool get isAuthenticated => _isAuthenticated;
  String get userName => _userName;
  String get email => _email;
  String get token => _token;
  DateTime get expire => _expire;

  // String get id => _id;
  // String get message => _message;
  // String get firstName => _firstName;
  // String get lastName => _lastName;
  // String get address => _address;
  // String get photo => _photo;
  // bool get isAuthenticated => _isAuthenticated;
  // String get userName => _userName;
  // String get email => _email;
  // String get password => _password;
  // String get token => _token;
  // DateTime get expire => _expire;

  set newIsAuthenticated(bool isAuthenticated) {
    _isAuthenticated = isAuthenticated;
  }

  set newUserName(String userName) {
    _userName = userName;
  }

  set newEmail(String email) {
    _email = email;
  }

  set newToken(String token) {
    _token = token;
  }

  set newExpire(DateTime expire) {
    _expire = expire;
  }

  //
  // set newIsAuthenticated(bool isAuthenticated) {
  //   _isAuthenticated = isAuthenticated;
  // }
  //
  // set newUserName(String userName) {
  //   _userName = userName;
  // }
  //
  // set newEmail(String email) {
  //   _email = email;
  // }
  //
  // set newPassword(String password) {
  //   _password = password;
  // }
  //
  // set newToken(String token) {
  //   _token = token;
  // }
  //
  // set newExpire(DateTime expire) {
  //   _expire = expire;
  // }

  // User.fromJson(dynamic json) {
  //   // this._id = json['id'];
  //   this.newFirstName = json['firstName'];
  //   this.newLastName = json['lastName'];
  //   this.newAddress = json['address'];
  //   this.newPhoto = json['photo'];
  //   this.newIsAuthenticated = json['isAuthenticated'];
  //   this.newUserName = json['userName'];
  //   this.newEmail = json['email'];
  //   this.newPassword = json['password'];
  //   this.newToken = json['token'];
  //   this.newExpire = json['expire'];
  // }

  User.fromJson(dynamic json) {
    // this._id = json['id'];
    this._message = json['message'];
    this.newIsAuthenticated = json['isAuthenticated'];
    this.newUserName = json['userName'];
    this.newEmail = json['email'];
    this.newToken = json['token'];
    this.newExpire = DateTime.parse(json['expire']);
  }
  // static FlutterSecureStorage storage = FlutterSecureStorage();
}
