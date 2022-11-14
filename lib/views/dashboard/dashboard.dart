import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/constants.dart';
import 'package:expensetracker/controllers/authcontroller.dart';
import 'package:expensetracker/controllers/transactioncontroller.dart';
import 'package:expensetracker/views/widgets/expensetransactioncard.dart';
import 'package:expensetracker/views/widgets/incomingtransactioncard.dart';
import 'package:expensetracker/views/widgets/moneycard.dart';
import 'package:expensetracker/views/widgets/newtransactionsheet.dart';
import 'package:expensetracker/views/widgets/transactiontoggler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final constants = Get.put(Constants());
  final authController = Get.put(AuthController());
  final transactionController = Get.put(TransactionController());
  final newTransactionSheetController = Get.put(NewTransactionSheet());

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
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2100));

                if (newDate == null) {
                  return;
                } else {
                  print("${newDate.day}-${newDate.month}-${newDate.year}");
                }

                // TimeOfDay? newTime = await showTimePicker(
                //     context: context, initialTime: TimeOfDay.now());
                // if (newTime == null) {
                //   return;
                // } else {
                //   print("${newTime.hour}:${newTime.minute}");
                // }
              },
              icon: const Icon(Icons.logout_rounded))
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newTransactionSheetController.newTransactionTypeSheet(context);
        },
        backgroundColor: constants.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: _size.width / 30,
              right: _size.width / 30,
              top: _size.height / 30),
          child: Column(
            children: [
              // Card
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot? doc = snapshot.data;
                    return MoneyCard(
                      size: _size,
                      constants: constants,
                      balanceIn: doc!['balanceIn'],
                      balanceOut: doc['balanceOut'],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: constants.primaryColor,
                      ),
                    );
                  }
                  return const Center(
                    child: Text('Error Fetching Data'),
                  );
                },
              ),

              // Selector
              Padding(
                padding: EdgeInsets.only(top: _size.height / 30),
                child: TransactionToogle(
                  size: _size,
                  constants: constants,
                ),
              ),

              const SizedBox(height: 20),

              Obx(
                () => currentPanel == 'Expense'
                    // Expense Transaction Sheet
                    ? Container(
                        width: double.infinity,
                        height: Get.height / 2.1,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('transactions')
                              .doc(FirebaseAuth.instance.currentUser?.uid
                                  .toString())
                              .collection('expense')
                              .snapshots(),
                          builder: ((context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];
                                  return ExpenseTransactionCard(
                                      size: _size,
                                      transactionAmount: data['amount'],
                                      transactionDate: data['date'],
                                      transactionTime: data['time'],
                                      transactionType: data['type']);
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: Get.height / 2.1,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('transactions')
                              .doc(FirebaseAuth.instance.currentUser?.uid
                                  .toString())
                              .collection('incoming')
                              .snapshots(),
                          builder: ((context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];
                                  return IncomingTransactionCard(
                                      size: _size,
                                      transactionAmount: data['amount'],
                                      transactionDate: data['date'],
                                      transactionTime: data['time'],
                                      transactionType: data['type']);
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
