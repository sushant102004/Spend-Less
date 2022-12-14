import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/constants.dart';
import 'package:expensetracker/controllers/authcontroller.dart';
import 'package:expensetracker/controllers/transactioncontroller.dart';
import 'package:expensetracker/views/groups/groups.dart';
import 'package:expensetracker/views/widgets/expensetransactioncard.dart';
import 'package:expensetracker/views/widgets/incomingtransactioncard.dart';
import 'package:expensetracker/views/widgets/moneycard.dart';
import 'package:expensetracker/views/widgets/newtransactionsheet.dart';
import 'package:expensetracker/views/widgets/transactiontoggler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  DateTime date = DateTime.now();
  RxString monthYear = ''.obs;

  @override
  void initState() {
    super.initState();
    monthYear.value =
        '${DateFormat('MMMM').format(date)}-${DateFormat('yyyy').format(date)}';
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constants.backgroundColor,
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
                              .where('monthYear', isEqualTo: '${monthYear}')
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
