import 'package:expensetracker/model/usermodel.dart';
import 'package:expensetracker/views/authentication/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> login(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        UserCredential result =
            await firebaseAuth.signInWithCredential(authCredential);
        User? user = result.user;
        Get.toNamed('/dashboard');

        // Save user details to DB
        // ignore: unnecessary_null_comparison
        if (firebaseFirestore.collection('users').doc(user?.uid) == null) {
          firebaseFirestore.collection('users').doc(user?.uid).set({
            'name': user?.displayName,
            'email': user?.email,
            'uid': user?.uid,
            'balanceIn': 0,
            'balanceOut': 0
          });
          print('Data Added');
        } else {
          print('Data Already Exists');
        }
      }
    } catch (e) {
      print('Something Went Wrong');
    }
  }

  getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  getCurrentUserUid() async {
    if (firebaseAuth.currentUser == null) {
      return null;
    }
    return firebaseAuth.currentUser?.uid.toString();
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    Get.off(Login());
  }
}
