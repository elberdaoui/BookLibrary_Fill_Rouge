import 'package:flutter/material.dart';
import 'package:book_library/components/custom_suffix_icon.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/form_error.dart';
import 'package:book_library/screens/otp/otp_screen.dart';
import 'package:book_library/size_config.dart';

import '../../../constants.dart';

class CompleteProfileForm extends StatefulWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(35)),
            buildFNameFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildLNameFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildPhoneFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildAddressFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: 'Continue',
              press: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, OtpScreen.routeName);
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
}
