import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wallet_v2/controller/data.service.dart';

typedef void IntCallback(int id);

class TransactionCard extends StatelessWidget {
  final IntCallback onDelete;
  final Transaction transaction;
  TransactionCard({Key key, this.transaction, @required this.onDelete})
      : super(key: key);

  stockIcon(raised) {
    return ClipRect(
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: raised ? Colors.lightBlue[400] : Colors.pink[600],
          ),
          child: Icon(
            raised ? Icons.trending_up : Icons.trending_down,
            color: Colors.white,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      height: 70,
      child: Container(
        child: Card(
          elevation: 0,
          color: Theme.of(context).backgroundColor,
          child: ListTile(
            onLongPress: () {
              onDelete(transaction.id);
            },
            trailing: Text(
              transaction.amount.toString() + '\$',
              style: TextStyle(
                color: transaction.isIncome == 1
                    ? Colors.lightBlue[300]
                    : Colors.pink,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            autofocus: true,
            leading: stockIcon(transaction.isIncome == 1),
            title: Text(
              transaction.title,
              style: TextStyle(
                color: transaction.isIncome == 1
                    ? Colors.lightBlue[300]
                    : Colors.pink,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
