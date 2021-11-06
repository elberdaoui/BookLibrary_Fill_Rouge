import 'dart:convert';
import 'dart:ffi';

// import 'package:book_library/models/User.dart';
import 'package:book_library/models/User.dart';
import 'package:book_library/services/api_book_library.dart';
import 'package:book_library/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:book_library/components/custom_suffix_icon.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/form_error.dart';
import 'package:book_library/screens/forgot_password/forgot_password_screen.dart';
import 'package:book_library/screens/login_success/login_success_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late String email = '';
  late String password = '';
  late bool remember = false;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  Map<String, String> headers = new Map();

  @override
  void initState() {
    // headers["Authorization"] = 'Bearer ${User.fromJson(null).token}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            // FormError(errors: errors),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              children: [
                Checkbox(
                    value: remember,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        remember = value!;
                      });
                    }),
                Text('Remember Me'),
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: Text('Forgot your password',
                      style: TextStyle(decoration: TextDecoration.underline)),
                )
              ],
            ),
            FormError(errors: errors),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            DefaultButton(
              text: 'Continue',
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Map<String, dynamic> map = Map<String, dynamic>();
                  ApiBookService.login(email, password).then((response) {
                    if (response.body.isNotEmpty)
                      map = json.decode(response.body);
                    print(response.statusCode);
                    var getToken = response.body.split(',')[5];
                    print(getToken);
                    var splitedToken = getToken.split('.')[1];
                    print(splitedToken);

                    if (response.statusCode == 200) {
                      SecureStorage secureStorage = SecureStorage();
                      setState(() {
                        secureStorage.writeData('jwt', getToken);
                      });
                      User.fromJson(map);
                      Navigator.pushNamed(
                          context, LoginSuccessScreen.routeName);
                    } else {
                      if (map.containsKey("message")) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => getAlertDialog(
                                'Login failed', '${map['message']}', context));
                      }
                    }
                  }).catchError((err) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => getAlertDialog(
                            "Login failed", '${err.toString()}', context));
                  });

                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  // ApiBookService.login(email, password);
                }
              },
            )
          ],
        ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newVal) => password = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (val.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return '';
        } else if (val.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return '';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Enter your password',
          labelText: 'Password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Lock.svg',
          )),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newVal) => email = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(val) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return '';
        } else if (!emailValidatorRegExp.hasMatch(val) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter your email',
          labelText: 'Email',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Mail.svg',
          )),
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
