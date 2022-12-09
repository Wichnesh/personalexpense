import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/Transaction.dart';

class ListofTransaction extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  ListofTransaction({required this.transaction, required this.deleteTx});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transaction.isEmpty
          ? const Center(
              child: Text(
                'No data found',
              ),
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  shadowColor: Colors.grey,
                  elevation: 5,
                  child: ListTile(
                    leading: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)),
                        child: Text(
                          '₹ ${transaction[index].amount?.toStringAsPrecision(6)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green),
                        )),
                    title: Text(
                      transaction[index].title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      DateFormat().format(transaction[index].dateTime!),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteTx(transaction[index].id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
