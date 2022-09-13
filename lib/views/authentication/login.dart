import 'package:expensetracker/constants.dart';
import 'package:expensetracker/controllers/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final constants = Get.put(Constants());
  final authController = Get.put(AuthController());

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
                Text(
                  'Manage Your',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Finance',
                  style: TextStyle(
                      color: constants.primaryColor,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
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
                  padding: EdgeInsets.only(top: _size.height / 8),
                  child: InkWell(
                    onTap: () {
                      authController.login(context);
                    },
                    child: Container(
                      width: _size.width / 2,
                      height: _size.height / 15,
                      decoration: BoxDecoration(
                          color: constants.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
