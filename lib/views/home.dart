import 'package:expensetracker/constants.dart';
import 'package:expensetracker/views/dashboard/dashboard.dart';
import 'package:expensetracker/views/groups/groups.dart';
import 'package:expensetracker/views/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final constants = Get.put(Constants());
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List pages = [const Dashboard(), const Groups(), const Settings()];
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: constants.backgroundColor,
        elevation: 0,
        title: Text(
          'Spend Less',
          style: TextStyle(
              color: constants.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_rounded))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: constants.primaryColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined), label: 'Groups'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
      body: pages.elementAt(selectedIndex),
    );
  }
}
