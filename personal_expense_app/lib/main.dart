import 'package:flutter/material.dart';
import 'Model/Transaction.dart';
import 'Widgets/AddTranscationscard.dart';
import 'Widgets/Chart.dart';
import 'Widgets/ListOfTransactionsWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
    // Transaction(
    //   id: '1',
    //   amount: 100,
    //   title: 'shoes',
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   amount: 150,
    //   title: 'vegetables',
    //   dateTime: DateTime.now(),
    // ),
  ];

  List<Transaction>? get _recentTransactions {
    return _transaction.where((tx) {
      return tx.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addtransationdata(String etitle, double eamount, DateTime presentdate) {
    final enew = Transaction(
        id: DateTime.now().toString(),
        amount: eamount,
        title: etitle,
        dateTime: presentdate);
    setState(() {
      _transaction.add(enew);
    });
  }

  void _Startaddtransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: addtransaction(_addtransationdata));
        });
  }

  void _deleteitem(String id) {
    setState(() {
      _transaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: const Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              _Startaddtransaction(context);
            },
            icon: const Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                child: chart(_recentTransactions!)),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.8,
              child: ListofTransaction(
                transaction: _transaction,
                deleteTx: _deleteitem,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _Startaddtransaction(context);
        },
      ),
    );
  }
}
