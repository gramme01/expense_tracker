import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTxs;

  Chart(this.recentTxs);

  List<Map<String, Object>> get groupedTxValues {
    return List.generate(7, (i) {
      final weekDay = DateTime.now().subtract(Duration(days: i));
      var totalSum = 0.0;

      for (var i = 0; i < recentTxs.length; i++) {
        if (recentTxs[i].date.day == weekDay.day &&
            recentTxs[i].date.month == weekDay.month &&
            recentTxs[i].date.year == weekDay.year) {
          totalSum += recentTxs[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum.toStringAsFixed(2),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTxValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTxValues.map((data) {
          return Text('${data['day']}: ${data['amount']}');
        }).toList(),
      ),
    );
  }
}
