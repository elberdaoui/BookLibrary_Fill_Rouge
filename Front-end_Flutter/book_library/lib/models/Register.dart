import 'dart:io';

import 'package:flutter/material.dart';

class Register {
  late String _firstName;
  late String _lastName;
  late String _userName;
  late String _email;
  late String _password;
  late String _address;
  late File _photo;

  Register(
    this._firstName,
    this._lastName,
    this._userName,
    this._email,
    this._password,
    this._address,
    this._photo,
  );

  File get photo => _photo;

  String get address => _address;

  String get password => _password;

  String get email => _email;

  String get userName => _userName;

  String get lastName => _lastName;

  String get firstName => _firstName;

  set newAddress(String address) {
    _address = address;
  }

  set newFirstName(String fName) {
    _firstName = fName;
  }

  set newLastName(String lName) {
    _lastName = lName;
  }

  set newPhoto(File photo) {
    _photo = photo;
  }

  set newPassword(String pass) {
    _password = pass;
  }

  set newEmail(String email) {
    _email = email;
  }

  set newUserName(String uName) {
    _userName = uName;
  }

  Register.fromJson(dynamic json) {
    this.newFirstName = json['firstName'];
    this.newLastName = json['lastName'];
    this.newUserName = json['userName'];
    this.newEmail = json['email'];
    this.newPassword = json['password'];
    this.newPhoto = json['profilePhoto'];
    this.newAddress = json['address'];
  }

  static Map<String, dynamic> toJson(Register register) => {
        'firstName': register.firstName,
        'lastName': register.lastName,
        'userName': register.userName,
        'email': register.email,
        'password': register.password,
        'profilePhoto': register.photo,
        'address': register.address,
      };
}
