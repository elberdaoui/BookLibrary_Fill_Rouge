import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProfilePhoto extends StatefulWidget {
  const SignUpProfilePhoto({Key? key}) : super(key: key);

  @override
  _SignUpProfilePhotoState createState() => _SignUpProfilePhotoState();
}

class _SignUpProfilePhotoState extends State<SignUpProfilePhoto> {
  late Map<String, dynamic> newPayload = {};
  late File img;
  ImagePicker _picker = ImagePicker();
  late String data;

  takeImage() async {
    var pickedImg = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      img = File(pickedImg!.path);
    });
    data = base64Encode(img.readAsBytesSync());
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            // backgroundImage: AssetImage('assets/images/Profile Image.png'),
            // backgroundImage: NetworkImage(newPayload['photo']),
            child: ClipOval(
              child: Image.memory(base64Decode(newPayload['photo'])),
            ),
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
