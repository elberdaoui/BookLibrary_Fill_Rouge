import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();
  Map<String, dynamic> payload = Map();

  Future writeData(String key, String value) async {
    var writtenData = await _storage.write(key: key, value: value);
    return writtenData;
  }

  Future readData(String key) async {
    var data = await _storage.read(key: key);
    return data;
  }

  Future deleteData(String key) async {
    var deletedData = await _storage.delete(key: key);
    return deletedData;
  }

  Future getTokenClaims(String jwt) async {
    payload = json.decode(
        utf8.decode(base64.decode(base64.normalize(jwt.split('.')[1]))));
    return payload;
  }
}
