import 'package:flutter/material.dart';

class IncomingTransactionCard extends StatelessWidget {
  const IncomingTransactionCard(
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                '₹ +$transactionAmount',
                style: TextStyle(
                    color: Colors.green.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            )
          ],
        ),
      ),
    );
  }
}
