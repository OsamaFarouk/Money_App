import 'package:expense_planner/Widgets/chartBar.dart';
import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay),
              'amount': totalSum
      };
    }).reversed.toList();
  }
  double get totalSpending{
    return transactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionValues.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(data['day'], data['amount'], totalSpending==0?0:(data['amount'] as double) / totalSpending));
          }).toList(),

        ),
      ),
    );
  }
}
