import 'package:flutter/material.dart';
import 'package:book_library/components/custom_suffix_icon.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/form_error.dart';
import 'package:book_library/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String email;
  late String password;
  late String confirmPassword;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(30)),
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConfirmPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(45)),
                FormError(errors: errors),
                DefaultButton(
                  text: 'Continue',
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(
                          context, CompleteProfileScreen.routeName);
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newVal) => confirmPassword = newVal!,
      onChanged: (val) {
        if (password == val) {
          setState(() {
            errors.remove(kPassNullError);
          });
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return '';
        } else if (password != val) {
          setState(() {
            errors.add(kMatchPassError);
          });
          return '';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Re-enter your password',
          labelText: 'Confirm password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Lock.svg',
          )),
    );
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
        password = val;
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
}
