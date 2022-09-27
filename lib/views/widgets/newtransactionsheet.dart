import 'package:expensetracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTransactionSheet extends GetxController {
  final constants = Get.put(Constants());

  showNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (builder) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Container(
                  height: Get.height / 15,
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
                          size: Get.size, constants: constants),
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
