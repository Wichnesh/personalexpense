import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addtransaction extends StatefulWidget {
  final Function eadd;
  addtransaction(this.eadd);

  @override
  State<addtransaction> createState() => _addtransactionState();
}

class _addtransactionState extends State<addtransaction> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _amountcontroller = TextEditingController();
  DateTime? _selecteddate;

  void _submitdata() {
    final enteredtitle = _titlecontroller.text;
    final enteredamount = double.parse(_amountcontroller.text);

    if (enteredtitle.isEmpty ||
        enteredamount <= 0 ||
        enteredtitle.length <= 1 ||
        _selecteddate == null) {
      return;
    } else {
      widget.eadd(enteredtitle, enteredamount, _selecteddate);
      Navigator.of(context).pop();
    }
  }

  void _presentdatepicker() async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _selecteddate = pickedData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        elevation: 5,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  controller: _titlecontroller,
                  onFieldSubmitted: (_) => _submitdata(),
                  decoration: const InputDecoration(
                    labelText: 'title',
                  ),
                ),
                TextFormField(
                  controller: _amountcontroller,
                  onFieldSubmitted: (_) => _submitdata(),
                  decoration: const InputDecoration(
                    labelText: 'amount',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Text(_selecteddate == null
                          ? 'No Date chosen!'
                          : DateFormat.yMd().format(_selecteddate!)),
                      TextButton(
                        onPressed: _presentdatepicker,
                        child: Text(
                          'Pick a Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: _submitdata,
                    child: const Text('Add Transaction'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
