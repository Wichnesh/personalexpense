import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';
import 'package:personal_expense_app/Model/Transaction.dart';

class chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  chart(this.recentTransaction);
  List<Map<String, dynamic>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime?.day == weekDay.day &&
            recentTransaction[i].dateTime?.month == weekDay.month &&
            recentTransaction[i].dateTime?.year == weekDay.year) {
          totalSum += recentTransaction[i].amount!;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: groupTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: Chartbar(
                label: e['day'],
                spendingAmount: (e['amount'] as double),
                spendingPctofTotal: totalSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
