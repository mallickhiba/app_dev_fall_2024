import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          if (state is TransactionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionsLoaded) {
            final transactions = state.transactions;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: transaction['imageUrl'] != null &&
                          transaction['imageUrl'].isNotEmpty
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(transaction['imageUrl']),
                          radius: 25,
                        )
                      : const CircleAvatar(
                          child: Icon(Icons.image_not_supported),
                          radius: 25,
                        ),
                  title: Text(transaction['to']),
                  subtitle: Text(_formatDate(transaction['date'])),
                  trailing: Text(
                    transaction['amount'] > 0
                        ? '+\$${transaction['amount']}'
                        : '-\$${transaction['amount'].abs()}',
                    style: TextStyle(
                      color:
                          transaction['amount'] > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            );
          } else if (state is TransactionsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No transactions found.'));
        },
      ),
    );
  }

  String _formatDate(dynamic date) {
    DateTime parsedDate;

    // Check if the date is a Timestamp from Firestore
    if (date is Timestamp) {
      parsedDate = date.toDate(); // Convert Timestamp to DateTime
    } else if (date is String) {
      parsedDate = DateTime.parse(date); // Parse String to DateTime
    } else {
      throw ArgumentError('Unsupported date format: $date');
    }

    final now = DateTime.now();
    if (parsedDate.day == now.day &&
        parsedDate.month == now.month &&
        parsedDate.year == now.year) {
      return 'Today';
    } else if (parsedDate.day == now.subtract(const Duration(days: 1)).day) {
      return 'Yesterday';
    } else {
      return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    }
  }
}
