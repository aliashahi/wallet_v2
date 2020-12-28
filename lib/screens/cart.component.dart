import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({Key key}) : super(key: key);
  final income = Random().nextBool();
  final amount = Random().nextInt(1000).toString() + '.99';
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
      child: Expanded(
        child: Container(
          child: Card(
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            child: ListTile(
              trailing: Text(
                amount + '\$',
                style: TextStyle(
                  color: income ? Colors.lightBlue[300] : Colors.pink,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              autofocus: true,
              leading: stockIcon(income),
              title: Text(
                'Balance',
                style: TextStyle(
                  color: income ? Colors.lightBlue[300] : Colors.pink,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
