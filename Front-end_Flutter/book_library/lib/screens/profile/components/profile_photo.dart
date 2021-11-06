import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:book_library/models/User.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  SecureStorage _storage = SecureStorage();
  Map<String, dynamic>? newPayload;
  late File img;
  ImagePicker _picker = ImagePicker();
  late String data;

  getUserInfo() async {
    String jwt = await _storage.readData('jwt');
    Map<String, dynamic> payload = await _storage.getTokenClaims(jwt);
    setState(() {
      newPayload = payload;
    });
  }

  takeImage() async {
    var pickedImg = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      img = File(pickedImg!.path);
    });
    data = base64Encode(img.readAsBytesSync());
    print(data);
    return data;
    // ImagePicker _picker = ImagePicker();
    // var img = await _picker.pickImage(source: ImageSource.camera);
    // File imageFile = File(img!.path);
    // String data = base64Encode(imageFile.readAsBytesSync());
    // print(data);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
    print(newPayload);
  }

  // late User? user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          newPayload != null
              ? CircleAvatar(
                  // backgroundImage: AssetImage('assets/images/Profile Image.png'),
                  // backgroundImage: NetworkImage(newPayload['photo']),
                  child: ClipOval(
                    child: Image.memory(base64Decode(newPayload!['photo'])),
                  ),
                )
              : CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/Profile Image.png'),
                ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: 46,
              height: 46,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white)),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  takeImage();
                },
                child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
