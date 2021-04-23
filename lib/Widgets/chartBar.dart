import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spindingAmount;
  final double spendingPrcTotal;
  final String label;

  ChartBar(this.label, this.spindingAmount, this.spendingPrcTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spindingAmount.toStringAsFixed(0)}'))),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 15,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        border: Border.all(color: Colors.grey, width: 1)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPrcTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                          border: Border.all(color: Colors.grey, width: 1)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
