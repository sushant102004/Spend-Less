import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  updateBalanceOut(int balanceOutAddAmount) async {
    final document = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid)
        .get()
        .then((document) => {
              firestore
                  .collection('users')
                  .doc(firebaseAuth.currentUser?.uid)
                  .update({
                'balanceOut': document['balanceOut'] + balanceOutAddAmount,
              })
            });
  }

  addBalanceOutTransaction(BuildContext context, int amount, String date,
      String time, String type) async {
    firestore
        .collection('transactions')
        .doc(firebaseAuth.currentUser?.uid.toString())
        .collection('expense')
        .add({'amount': amount, 'date': date, 'time': time, 'type': type});
    updateBalanceOut(amount);
    Navigator.pop(context);
  }

  updateBalanceIn(int balanceOutAddAmount) async {
    final document = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid)
        .get()
        .then((document) => {
              firestore
                  .collection('users')
                  .doc(firebaseAuth.currentUser?.uid)
                  .update({
                'balanceIn': document['balanceIn'] + balanceOutAddAmount,
              })
            });
  }

  addBalanceInTransaction(BuildContext context, int amount, String date,
      String time, String type) async {
    firestore
        .collection('transactions')
        .doc(firebaseAuth.currentUser?.uid.toString())
        .collection('incoming')
        .add({'amount': amount, 'date': date, 'time': time, 'type': type});
    updateBalanceIn(amount);
    Navigator.pop(context);
  }
}
