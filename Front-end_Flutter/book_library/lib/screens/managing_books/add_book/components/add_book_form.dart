import 'dart:convert';
import 'dart:io';

import 'package:book_library/components/custom_suffix_icon.dart';
import 'package:book_library/components/default_button.dart';
import 'package:book_library/components/form_error.dart';
import 'package:book_library/services/api_book_library.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../manage_screen.dart';

class AddBookForm extends StatefulWidget {
  const AddBookForm({Key? key}) : super(key: key);

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String bookName;
  late String description;
  late double price;
  late bool isFav;
  late double rating;
  // late String publishedDate;
  late DateTime publishedDate;
  late int quantity;
  late File photo;
  String? convImg;
  ImagePicker _picker = ImagePicker();
  String defaultImg = 'assets/images/defImgBook.jpg';

  takeImage() async {
    var pickedImg = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImg != null
          ? photo = File(pickedImg.path)
          : photo = File(defaultImg);
    });
    convImg = base64Encode(photo.readAsBytesSync());
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(35)),
            buildBookNameFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildDescFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildPriceFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildQuantityFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            buildPubDateFormField(),
            SizedBox(height: getProportionateScreenHeight(35)),
            // InputDatePickerFormField(firstDate: null, lastDate: null,),
            bookPhoto(),
            SizedBox(height: getProportionateScreenHeight(40)),
            FormError(errors: errors),
            DefaultButton(
              text: 'Save',
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ApiBookService.addBook(bookName, description, price,
                          publishedDate, quantity, photo)
                      .then((response) {
                    if (response.statusCode == 200) {
                      print(response.statusCode);
                      print('added');
                      Navigator.pushNamed(context, ManageScreen.routeName);
                    } else {
                      print('something wrong');
                    }
                  });
                  print(publishedDate);
                }
              },
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
          ],
        ),
      ),
    );
  }

  TextFormField buildBookNameFormField() {
    return TextFormField(
      onSaved: (newVal) => bookName = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kBookNameNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kBookNameNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter your book name',
          labelText: 'Book name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Location point.svg',
          )),
    );
  }

  TextFormField buildDescFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newVal) => description = newVal!,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kDescNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kDescNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter description',
          labelText: 'Description',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.description)),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newVal) => price = double.parse(newVal!),
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kPriceNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kPriceNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter book price',
        labelText: 'Price',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Cash.svg',
        ),
      ),
    );
  }

  TextFormField buildRatingFormField() {
    return TextFormField(
      onSaved: (newVal) => rating = double.parse(newVal!),
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kRatingNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kRatingNullError);
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

  TextFormField buildFavFormField() {
    return TextFormField(
      onSaved: (newVal) => isFav = newVal! as bool,
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kFavNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kFavNullError);
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

  TextFormField buildQuantityFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newVal) => quantity = int.parse(newVal!),
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kQuantityNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kQuantityNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Enter quantity',
          labelText: 'Quantity',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_box)),
    );
  }

  TextFormField buildPubDateFormField() {
    return TextFormField(
      // keyboardType: TextInputType.text,
      onSaved: (newVal) => publishedDate = DateTime.parse(newVal!),
      // onSaved: (newVal) => publishedDate = DateFormat('MM/dd/yyyy').format(
      //     DateFormat.yMd('en_US').parse(
      //         newVal!)), //DateFormat.yMd('en_US').parse(newVal!).toString(),
      onChanged: (val) {
        if (val.isNotEmpty) {
          removeError(error: kPubDateNullError);
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty) {
          addError(error: kPubDateNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Format mm/dd/yyy',
          labelText: 'Published date',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Location point.svg',
          )),
    );
  }

  SizedBox bookPhoto() {
    return SizedBox(
      // width: getProportionateScreenWidth(scWidth),
      child: AspectRatio(
        aspectRatio: 2.2,
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(5)),
          decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            // iconSize: 100,
            icon: convImg != null
                ? Image.memory(
                    base64Decode(convImg!),
                    fit: BoxFit.cover,
                  )
                : Image.asset(defaultImg),
            onPressed: () {
              takeImage();
            },
          ),
        ),
      ),
    );
  }
}
