import 'dart:async';
import 'package:expensetracker/constants.dart';
import 'package:expensetracker/views/authentication/login.dart';
import 'package:expensetracker/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final constants = Get.put(Constants());

  setScreen() async {
    Timer(const Duration(seconds: 3), () async {
      final userStatus = FirebaseAuth.instance.currentUser;
      if (userStatus == null) {
        Get.off(Login());
      } else {
        Get.off(const Home());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setScreen();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: constants.primaryColor,
      body: Column(
        children: [
          Container(
            height: _size.height / 2.3,
            alignment: Alignment.center,
            // child: Center(
            //   child: Container(
            //     height: _size.height / 3.5,
            //     width: _size.width / 1.5,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(100)),
            //     child: SvgPicture.asset(
            //       'assets/svg/login/login.svg',

            //     ),
            //   ),
            // ),
            child: SvgPicture.asset(
              'assets/svg/login/login.svg',
              color: Colors.white,
              width: 250,
            ),
          ),
          Container(
            height: _size.height / 1.77,
            width: double.infinity,
            decoration: BoxDecoration(
                color: constants.backgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(
                  height: _size.height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Spend ',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Less',
                      style: TextStyle(
                          color: constants.primaryColor,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: _size.width / 10,
                      right: _size.width / 10,
                      top: _size.height / 25),
                  child: Text(
                    'Manage your finanace easily and securely',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _size.height / 6),
                  child: CircularProgressIndicator(
                    color: constants.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
