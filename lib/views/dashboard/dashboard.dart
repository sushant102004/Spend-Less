import 'package:expensetracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final constants = Get.put(Constants());
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constants.backgroundColor,
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
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: constants.primaryColor,
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: _size.height / 3,
              width: double.infinity,
              color: constants.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      radius: 45,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Hello 👋 Sushant Dhiman",
                      style: TextStyle(
                          color: constants.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "sushant.dhiman9812@gmail.com",
                      style: TextStyle(
                        color: constants.textColor,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: _size.width / 30,
            right: _size.width / 30,
            top: _size.height / 30),
        child: Column(
          children: [
            // Card
            Container(
              height: _size.height / 4.7,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: constants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.all(_size.width / 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This Month',
                      style: TextStyle(
                          color: constants.textColor,
                          // fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: _size.height / 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Balance In ↓',
                          style: TextStyle(
                              color: constants.textColor,
                              // fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                        Text(
                          'Balance Out ↑',
                          style: TextStyle(
                              color: constants.textColor,
                              // fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _size.height / 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ 13900',
                          style: TextStyle(
                              color: constants.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        Text(
                          '₹ 76400',
                          style: TextStyle(
                              color: constants.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Selector
            Padding(
              padding: EdgeInsets.only(top: _size.height / 30),
              child: Container(
                height: _size.height / 20,
                width: _size.width / 1.18,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: _size.width / 2.45,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: constants.backgroundColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_circle_up,
                              color: constants.primaryColor,
                            ),
                            SizedBox(
                              width: _size.width / 40,
                            ),
                            Text(
                              'Expense',
                              style: TextStyle(
                                  color: constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: _size.width / 2.45,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            // color: constants.backgroundColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_circle_down,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(
                              width: _size.width / 40,
                            ),
                            Text(
                              'Incoming',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: _size.width / 1.1,
              height: _size.height / 10,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _size.width / 15,
                        vertical: _size.width / 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Food',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700),
                        ),
                        Text(
                          '22 September 2022',
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade600),
                        ),
                        Text(
                          '06:00 AM',
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: _size.width / 15),
                    child: Text(
                      '-₹400',
                      style: TextStyle(
                          color: Colors.red.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
