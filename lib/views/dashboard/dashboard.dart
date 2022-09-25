import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/constants.dart';
import 'package:expensetracker/controllers/authcontroller.dart';
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
              onPressed: () {
                // authController.signOut();
                print(authController.getCurrentUserUid());
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              builder: (builder) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Wrap(
                    children: [
                      Container(
                        height: _size.height / 15,
                        decoration: BoxDecoration(
                            color: constants.primaryColor,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10))),
                        child: Center(
                          child: Text(
                            'New Transaction',
                            style: TextStyle(
                                color: constants.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: Get.height / 50,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TransactionToogle(
                                size: _size, constants: constants),
                          ),
                          SizedBox(
                            height: Get.height / 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.height / 30, right: Get.height / 30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amount',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height / 80,
                                ),
                                SizedBox(
                                  height: Get.height / 18,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'eg: 400',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height / 30,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
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
                child: TransactionToogle(size: _size, constants: constants),
              ),
              const SizedBox(height: 20),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
                    .doc('Iiz60pNr3OWywoA6n3dqTRmKBkD3')
                    .collection('expense')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        return ExpenseTransaction(
                            size: _size,
                            transactionAmount: doc['amount'],
                            transactionDate: doc['date'],
                            transactionTime: doc['time'],
                            transactionType: doc['type']);
                      }),
                    );
                  }
                  return Center(
                      child: CircularProgressIndicator(
                          color: constants.primaryColor));
                }),
              ),

              // ExpenseTransaction(size: _size)
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseTransaction extends StatelessWidget {
  const ExpenseTransaction(
      {Key? key,
      required Size size,
      required this.transactionAmount,
      required this.transactionDate,
      required this.transactionTime,
      required this.transactionType})
      : _size = size,
        super(key: key);

  final Size _size;
  final String transactionType;
  final String transactionDate;
  final String transactionTime;
  final int transactionAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                horizontal: _size.width / 15, vertical: _size.width / 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionType,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ),
                Text(
                  transactionDate,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
                Text(
                  transactionTime,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: _size.width / 15),
            child: Text(
              '₹ -$transactionAmount',
              style: TextStyle(
                  color: Colors.red.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          )
        ],
      ),
    );
  }
}

class MoneyCard extends StatelessWidget {
  const MoneyCard(
      {Key? key,
      required Size size,
      required this.constants,
      required this.balanceIn,
      required this.balanceOut})
      : _size = size,
        super(key: key);

  final Size _size;
  final Constants constants;
  final int balanceIn;
  final int balanceOut;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  '₹ $balanceIn',
                  style: TextStyle(
                      color: constants.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
                Text(
                  '₹ $balanceOut',
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
    );
  }
}

class TransactionToogle extends StatelessWidget {
  const TransactionToogle({
    Key? key,
    required Size size,
    required this.constants,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final Constants constants;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
