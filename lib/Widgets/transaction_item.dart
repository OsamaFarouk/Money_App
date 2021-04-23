import 'dart:math';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTx;

  TransactionItem(
      {Key key, @required this.transaction, @required this.deleteTx})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  // Color bgColor;
  //
  // void initState(){
  //   const avaliableColors= [
  //     Color(0xFF808080),
  //     Color(0xFFA9A9A9),
  //     Color(0xFFC0C0C0),
  //     Color(0xFFD3D3D3),
  //     Color(0xFF8B0000),
  //   ];
  //
  //   bgColor = avaliableColors[Random().nextInt(4)];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 7,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 19),

              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(
            widget.transaction.date,
          ),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: MediaQuery.of(context).size.width > 600
            ? FlatButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
