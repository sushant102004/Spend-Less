import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addTransaction(BuildContext context, int amount, String date, String time,
      String type) async {
    firestore
        .collection('transactions')
        .doc(firebaseAuth.currentUser?.uid.toString())
        .collection('expense')
        .add({'amount': amount, 'date': date, 'time': time, 'type': type});

    var snackBar = const SnackBar(
      content: Text("Transaction Added"),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
