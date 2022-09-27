import 'package:expensetracker/constants.dart';
import 'package:flutter/material.dart';

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
