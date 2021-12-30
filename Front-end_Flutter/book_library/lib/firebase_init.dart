// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// class FirebaseInit {
//   late FirebaseFirestore firestore;
//   firebaseInitialize() async {
//     firestore = FirebaseFirestore.instance;
//   }

// Future<List> getData() async {
//   QuerySnapshot querySnapshot;
//   List docs;
//   try {
//     querySnapshot = await firestore.collection('carts').get();
//     if (querySnapshot.docs.isNotEmpty) {
//       for (var doc in querySnapshot.docs.toList()) {}
//     }
//   } catch (e) {}
// }
// }
