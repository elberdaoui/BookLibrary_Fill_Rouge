import 'package:book_library/screens/managing_books/manage_screen.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/screens/home/home_screen.dart';
import 'package:book_library/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SecureStorage _storage = SecureStorage();
  late Map<String, dynamic> payload = {};
  String? jwt;

  getPayload() async {
    jwt = await _storage.readData('jwt');
    Map<String, dynamic> payloadList = await _storage.getTokenClaims(jwt!);
    setState(() {
      payload = payloadList;
    });
  }

  @override
  void initState() {
    getPayload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight! * 0.04,
          ),
          Image.asset(
            'assets/images/success.png',
            height: SizeConfig.screenHeight! * 0.5,
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.08,
          ),
          Text(
            'Login Success',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth! * 0.7,
            child: DefaultButton(
              text:
                  'Back ${payload['roles'] == 'Admin' ? 'to Manage' : 'Home'}',
              press: () {
                payload['roles'] == 'Admin'
                    ? Navigator.pushNamed(context, ManageScreen.routeName)
                    : Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
