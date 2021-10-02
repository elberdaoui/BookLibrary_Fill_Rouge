import 'package:flutter/material.dart';
import 'package:book_library/components/custom_suffix_icon.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/form_error.dart';
import 'package:book_library/components/no_account.dart';
import 'package:book_library/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * 0.1,
              ),
              Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'Please enter your email to send \nyou password restoring link',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.1,
              ),
              ForgotPasswordForm()
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
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
              } else if (!emailValidatorRegExp.hasMatch(val) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
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
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          FormError(errors: errors),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          DefaultButton(
            text: 'Continue',
            press: () {
              if (_formKey.currentState!.validate()) {}
            },
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          NoAccountText(),
        ],
      ),
    );
  }
}
