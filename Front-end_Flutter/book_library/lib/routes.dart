import 'package:book_library/screens/credit_card/credit_card.dart';
import 'package:book_library/screens/credit_card/existing_credit_card/existing_card_srceen.dart';
import 'package:flutter/material.dart';
import 'package:book_library/screens/cart/cart_screen.dart';
import 'package:book_library/screens/complete_profile/complete_profile_screen.dart';
import 'package:book_library/screens/details/details_screen.dart';
import 'package:book_library/screens/forgot_password/forgot_password_screen.dart';
import 'package:book_library/screens/home/home_screen.dart';
import 'package:book_library/screens/login_success/login_success_screen.dart';
import 'package:book_library/screens/otp/otp_screen.dart';
import 'package:book_library/screens/profile/profile_screen.dart';
import 'package:book_library/screens/sign_in/sign_in_screen.dart';
import 'package:book_library/screens/sign_up/sign_up_screen.dart';
import 'package:book_library/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ExistingCardScreen.routeName: (context) => ExistingCardScreen(),
  CreditCards.routeName: (context) => CreditCards(),
};
