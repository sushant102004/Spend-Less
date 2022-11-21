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
  bool hasGroupCreated = true;
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
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Get.width / 20),
                  child: Container(
                    alignment: Alignment.center,
                    height: Get.height / 11,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          )
                        ]),
                    child: ListTile(
                      title: Text(
                        'Group Title',
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: constants.primaryColor,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                        ),
                        onPressed: () {},
                      ),
                      subtitle: const Text(
                        'Sushant, Kunal, Vishal....',
                        maxLines: 1,
                      ),
                    ),
                  ),
                )
              ],
            )
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
