import 'package:expensetracker/constants.dart';
import 'package:expensetracker/controllers/transactioncontroller.dart';
import 'package:expensetracker/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewTransactionSheet extends GetxController {
  final constants = Get.put(Constants());
  final transactionController = Get.put(TransactionController());
  TextEditingController amountController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  RxString transactionType = ''.obs;
  RxString date = 'Select Date'.obs;
  RxString time = 'Select Time'.obs;

  newTransactionTypeSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                            onTap: () {
                              transactionType.value = 'expense';
                              showNewTransactionSheet(context);
                            },
                            text: 'Expense',
                            fontSize: 18,
                            height: Get.height / 18,
                            width: Get.width / 2.5),
                        SizedBox(
                          width: Get.width / 10,
                        ),
                        CustomButton(
                            onTap: () {
                              transactionType.value = 'incoming';
                              showNewTransactionSheet(context);
                            },
                            text: 'Incoming',
                            fontSize: 18,
                            height: Get.height / 18,
                            width: Get.width / 2.5),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void dateControl(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2100));

    if (pickedDate == null) {
      return;
    } else {
      // date.value =
      // "${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year}";
      date.value = DateFormat('dd-MMMM-yyyy').format(pickedDate);
    }
  }

  void timeControl(BuildContext context) async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (newTime == null) {
      return;
    } else {
      if (newTime.hour == 12 || newTime.hour > 12) {
        time.value = "${newTime.hour} : ${newTime.minute} PM";
      } else if (newTime.hour == 12 || newTime.hour > 12) {
        time.value = "${newTime.hour - 12} : ${newTime.minute} PM";
      } else {
        time.value = "${newTime.hour} : ${newTime.minute} AM";
      }
    }
  }

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
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: TransactionToogle(
                    //     size: Get.size,
                    //     constants: constants,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      title: 'Amount',
                      hintText: 'eg: 400',
                      textController: amountController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      title: 'Type',
                      hintText: 'eg: Food',
                      textController: typeController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.height / 30, right: Get.height / 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Date Picker
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                            left: Get.height / 30, right: Get.height / 30),
                        child: Container(
                          width: double.infinity,
                          height: Get.height / 20,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: Get.width / 30),
                                child: Text(
                                  "$date",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: constants.primaryColor,
                                ),
                                onPressed: () {
                                  dateControl(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Time Picker
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.height / 30, right: Get.height / 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Time",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Date Picker
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                            left: Get.height / 30, right: Get.height / 30),
                        child: Container(
                          width: double.infinity,
                          height: Get.height / 20,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: Get.width / 30),
                                child: Text(
                                  "$time",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: constants.primaryColor,
                                ),
                                onPressed: () {
                                  timeControl(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onTap: () {
                        transactionType == 'expense'
                            ? transactionController.addBalanceOutTransaction(
                                context,
                                int.parse(amountController.text),
                                date.value,
                                time.value,
                                typeController.text)
                            : transactionController.addBalanceInTransaction(
                                context,
                                int.parse(amountController.text),
                                date.value,
                                time.value,
                                typeController.text);
                      },
                      text: 'Add Transaction',
                      height: Get.height / 18,
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
