import 'dart:convert';
import 'dart:io';

import 'package:book_library/models/Register.dart';
import 'package:book_library/screens/profile/components/profile_photo.dart';
import 'package:book_library/screens/sign_in/sign_in_screen.dart';
import 'package:book_library/screens/sign_up/components/sign_up_form.dart';
import 'package:book_library/services/api_book_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/custom_suffix_icon.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/form_error.dart';
import 'package:book_library/screens/otp/otp_screen.dart';
import 'package:book_library/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../constants.dart';

class CompleteProfileForm extends StatefulWidget {
  // final String email;
  // final String pass;
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String address;
  late String userName;

  // late Map<String, dynamic> newPayload = {};
  File? img;
  ImagePicker _picker = ImagePicker();
  String? photo;
  String defaultImg = 'assets/images/Profile Image.png';
  // String? data;

  // final maskFormatter = new MaskTextInputFormatter(mask: '+# (###) ###-##-##');
  takeImage() async {
    var pickedImg = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      pickedImg != null ? img = File(pickedImg.path) : img = File(defaultImg);
    });
    photo = base64Encode(img!.readAsBytesSync());
    print(photo);
    return photo;
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SignUpFormArguments args =
        ModalRoute.of(context)!.settings.arguments as SignUpFormArguments;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // SizedBox(height: getProportionateScreenHeight(35)),
            photoProfile(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildFNameFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildUserNameFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildLNameFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            // buildPhoneFormField(),
            // SizedBox(height: getProportionateScreenHeight(35)),
            buildAddressFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: 'Continue',
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Map<String, dynamic> map = Map<String, dynamic>();
                  // Register reg = Register(firstName, lastName, userName,
                  //     args.email, args.pwd, address, img);
                  ApiBookService.register(args.email, args.pwd, firstName,
                          lastName, userName, address, img!)
                      // ApiBookService.register(reg)
                      .then((response) {
                    if (response.statusCode == 200) {
                      // map = json.decode(response.body);
                      // var res = json.decode(response.body);
                      Navigator.pushNamed(context, SignInScreen.routeName);
                      // print(res);
                    } else {
                      if (map.containsKey("Message")) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => getAlertDialog(
                                'Signing Up failed',
                                '${map['Message']}',
                                context));
                      }
                    }
                  });
                  // Navigator.pushNamed(context, OtpScreen.routeName);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newVal) => address = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kAddressNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter your address',
          labelText: 'Address',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Location point.svg',
          )),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      onSaved: (newVal) => userName = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kAddressNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter your User Name',
          labelText: 'User Name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/User Icon.svg',
          )),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newVal) => phoneNumber = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter your phone number',
          labelText: 'Phone Number',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Phone.svg',
          )),
      // inputFormatters: [maskFormatter],
    );
  }

  TextFormField buildLNameFormField() {
    return TextFormField(
      onSaved: (newVal) => lastName = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kNameNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter your last name',
          labelText: 'Last Name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/User Icon.svg',
          )),
    );
  }

  TextFormField buildFNameFormField() {
    return TextFormField(
      onSaved: (newVal) => firstName = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kNameNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter your first name',
          labelText: 'First Name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/User.svg',
          )),
    );
  }

  SizedBox photoProfile() {
    return SizedBox(
      width: 115,
      height: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          photo != null
              ? CircleAvatar(
                  child: ClipOval(
                    child: Image.memory(
                      base64Decode(photo!),
                    ),
                  ),
                )
              : CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/Profile Image.png'),
                  backgroundColor: Color(0xEEEEEE),
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

  AlertDialog getAlertDialog(title, content, context) {
    return AlertDialog(
      title: Text('$title'),
      content: Text('$content'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('Close'))
      ],
    );
  }
}
