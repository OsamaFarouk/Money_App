import 'dart:ui';

import 'package:expense_planner/Widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      'No Transactions !',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'images/nodata.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView(
              children: transactions
                  .map((e) => TransactionItem(
                      key: ValueKey(e.id), transaction: e, deleteTx: deleteTx))
                  .toList(),
            ),
    );
  }
}
