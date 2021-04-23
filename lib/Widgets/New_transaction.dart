import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    if (titleInput.text.isEmpty) {
      return;
    }
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void DatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'.toString()),
                controller: titleInput,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Amount'.toString()),
                  controller: amountInput,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      selectedDate == null
                          ? 'No Date!'
                          : DateFormat.yMd().format(selectedDate),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    FlatButton(
                        onPressed: DatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 17 * curScaleFactor,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: submitData,
                  child: Text(
                    'Add transaction',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17 * curScaleFactor),
                  ),
                  textColor: Colors.white,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
