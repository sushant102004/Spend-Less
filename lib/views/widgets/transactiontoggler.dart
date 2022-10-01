import 'package:expensetracker/constants.dart';
import 'package:flutter/material.dart';

String currentPanel = 'Expense';

class TransactionToogle extends StatefulWidget {
  TransactionToogle({
    Key? key,
    required Size size,
    required this.constants,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final Constants constants;

  @override
  State<TransactionToogle> createState() => _TransactionToogleState();
}

class _TransactionToogleState extends State<TransactionToogle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._size.height / 20,
      width: widget._size.width / 1.18,
      decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(100)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: widget._size.width / 2.45,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: widget.constants.backgroundColor,
                  borderRadius: BorderRadius.circular(100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_circle_up,
                    color: widget.constants.primaryColor,
                  ),
                  SizedBox(
                    width: widget._size.width / 40,
                  ),
                  Text(
                    'Expense',
                    style: TextStyle(
                        color: widget.constants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentPanel = 'Incoming';
                  print(currentPanel);
                });
              },
              child: Container(
                width: widget._size.width / 2.45,
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
                      width: widget._size.width / 40,
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
            ),
          ],
        ),
      ),
    );
  }
}
