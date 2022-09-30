import 'package:expensetracker/constants.dart';
import 'package:expensetracker/controllers/transactioncontroller.dart';
import 'package:expensetracker/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTransactionSheet extends GetxController {
  final constants = Get.put(Constants());
  final transactionController = Get.put(TransactionController());
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController typeController = TextEditingController();

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
                    CustomInputField(
                      title: 'Amount',
                      hintText: 'eg: 400',
                      textController: amountController,
                    ),
                    CustomInputField(
                      title: 'Date',
                      hintText: 'eg: 26 September 2022',
                      textController: dateController,
                    ),
                    CustomInputField(
                      title: 'Time',
                      hintText: 'eg: 01:00 PM',
                      textController: timeController,
                    ),
                    CustomInputField(
                      title: 'Type',
                      hintText: 'eg: Food',
                      textController: typeController,
                    ),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                    CustomButton(
                      onTap: () {
                        transactionController.addTransaction(
                            context,
                            int.parse(amountController.text),
                            dateController.text,
                            timeController.text,
                            typeController.text);
                      },
                      text: 'Add Transaction',
                      height: Get.height / 16,
                      width: Get.width / 2.5,
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class CustomInputField extends StatelessWidget {
  CustomInputField({
    Key? key,
    required this.hintText,
    required this.title,
    required this.textController,
  }) : super(key: key);

  String title;
  String hintText;
  TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Get.height / 30, right: Get.height / 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.height / 18,
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                  hintText: hintText,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
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
