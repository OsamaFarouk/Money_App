import 'dart:ui';
import 'dart:io';
import 'package:expense_planner/Widgets/New_transaction.dart';
import 'package:expense_planner/Widgets/chart.dart';
import 'package:expense_planner/Widgets/transaction_List.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(),
        title: 'Where\'s My Money?',
        theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.amberAccent,
            fontFamily: 'OpenSans',
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black,
                )),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 25,
                        fontWeight: FontWeight.w700)))));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactionsList = [];
  bool showChart = false;

  List<Transaction> get recentTransactions {
    return transactionsList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      date: chosenDate,
    );

    setState(() {
      transactionsList.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactionsList.removeWhere((tx) => tx.id == id);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(addNewTransaction),
            onTap: () => {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Widget> buildLandScape(AppBar appBar, Widget widget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
              value: showChart,
              onChanged: (val) {
                setState(() {
                  showChart = val;
                });
              }),
        ],
      ),
      showChart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.8,
              child: Chart(recentTransactions))
          : widget
    ];
  }

  List<Widget> buildPortrate(AppBar appBar, Widget widget) {
    return [
      Container(
          height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              0.3,
          child: Chart(recentTransactions)),
      widget
    ];
  }

  Widget buildCupertinoBar() {
    return CupertinoNavigationBar(
      backgroundColor: Colors.red,
      middle: Container(
          alignment: Alignment.center,
          child: Text(
            'Where\'s My Money?',
            style: TextStyle(color: Colors.white,fontSize: 20),
          )),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add,color: Colors.white,),
            onTap: () => {startNewTransaction(context)},
          )
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.red,
      title: Container(
          alignment: Alignment.center,
          child: Text('Where\'s My Money?',
              style: TextStyle(color: Colors.white,fontSize: 20))),
      actions: [
        IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => {startNewTransaction(context)})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final AppBar appBar = buildAppBar();
    final txList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(transactionsList, deleteTransaction));
    final singleWidget = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isLandScape) ...buildLandScape(appBar, txList),
            if (!isLandScape) ...buildPortrate(appBar, txList),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: singleWidget,
            navigationBar: buildCupertinoBar(),
          )
        : Scaffold(
            appBar: appBar,
            body: singleWidget,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                    onPressed: () => {
                      startNewTransaction(context),
                    },
                  ),
          );
  }
}
