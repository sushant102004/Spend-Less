import 'package:expensetracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final constants = Get.put(Constants());
  bool hasGroupCreated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: constants.primaryColor,
        child: Icon(
          Icons.group_add,
          color: constants.textColor,
        ),
      ),
      body: hasGroupCreated
          ? Container()
          : Padding(
              padding: EdgeInsets.all(Get.width / 20),
              child: Center(
                child: Text(
                  'Oops! You have not created any group yet.',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
