import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addTransaction(int amount, String date, String time, String type) async {
    firestore
        .collection('transactions')
        .doc('Iiz60pNr3OWywoA6n3dqTRmKBkD3')
        .collection('expense')
        .add({'amount': amount, 'date': date, 'time': time, 'type': type});

    print('Data Added');
  }
}
