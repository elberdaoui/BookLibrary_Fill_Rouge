// import 'package:flutter/services.dart';
// import 'package:stripe_payment/stripe_payment.dart';
// import 'package:http/http.dart' as http;
//
// class StripeService {
//   static String apiURL = 'https://api.stripe.com/v1';
//   static String paymentApiUrl = '${StripeService.apiURL}/payment_intents';
//   static String secret =
//       'sk_test_51GLqzkAJGGZysCz4qio9wvIHvdv0jbXjQXwoj3tLw3orYuq7kSX5hb5F8m1H5uA3FOOGtMapHreJGR7nr3eAvXUi00YVstZyMK'; //your secret from stripe dashboard
//   static Map<String, String> headers = {
//     'Authorization': 'Bearer ${StripeService.secret}',
//     'Content-Type': 'application/x-www-form-urlencoded'
//   };
//   static init() {
//     StripePayment.setOptions(StripeOptions(
//         publishableKey:
//             "pk_test_51GLqzkAJGGZysCz41o5XhDczmQ5vOGVxqHzXilyMuhkLaHGVpBLeEpXKGol3rxCr5iYWdPwBNi3eqphvoVvSaKrk00uDBJk4zi", // user your api key
//         merchantId: "Test",
//         androidPayMode: 'test'));
//   }
//
//   static Future<PaymentResponse> choseExistingCard(
//       {String? amount, String? currency, CreditCard? card}) async {
//     try {
//       var stripePaymentMethod = await StripePayment.createPaymentMethod(
//           PaymentMethodRequest(card: card));
//       var stripePaymentIntent =
//           await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: stripePaymentIntent['client_secret'],
//           paymentMethodId: stripePaymentMethod.id));
//
//       if (response.status == 'succeeded') {
//         //if the payment process success
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         //payment process fail
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (error) {
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (error) {
//       return new StripeTransactionResponse(
//           //convert the error to string and assign to message variable for json resposne
//           message: 'Transaction failed: ${error.toString()}',
//           success: false);
//     }
//   }
//
//   static Future<StripeTransactionResponse> addNewCard(
//       {String amount, String currency}) async {
//     try {
//       var stripePaymentMethod = await StripePayment.paymentRequestWithCardForm(
//           CardFormPaymentRequest());
//       var stripePaymentIntent =
//           await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: stripePaymentIntent['client_secret'],
//           paymentMethodId: stripePaymentMethod.id));
//
//       if (response.status == 'succeeded') {
//         //if the payment process success
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         //payment process fail
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (error) {
//       return StripeService.getPlatformExceptionErrorResult(error);
//     } catch (error) {
//       return new StripeTransactionResponse(
//           //convert the error to string and assign to message variable
//           message: 'Transaction failed: ${error.toString()}',
//           success: false);
//     }
//   }
//
//   static Future<Map<String, dynamic>> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount':
//             amount, // amount charged will be specified when the method is called
//         'currency': currency, // the currency
//         'payment_method_types[]': 'card' //card
//       };
//       var response = await http.post(StripeService.paymentApiUrl, //api url
//           body: body, //request body
//           headers: StripeService
//               .headers //headers of the request specified in the base class
//           );
//       return jsonDecode(response.body); //decode the response to json
//     } catch (error) {
//       print('Error occured : ${error.toString()}');
//     }
//     return null;
//   }
// }
//
// class PaymentResponse {
//   String? message; // message from the response
//   bool? success; //state of the processs
//
//   //class constructor
//   PaymentResponse({this.message, this.success});
// }
