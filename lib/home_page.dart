import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Perform overflow menu action
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monday',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '17 Nov',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      '\$2,983', // Replace with dynamic balance if needed
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),

          // Transaction List
          Expanded(
            child: BlocBuilder<TransactionsBloc, TransactionsState>(
              builder: (context, state) {
                if (state is TransactionsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TransactionsLoaded) {
                  final transactions = state.transactions;
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Transaction Icon or Image
                                transaction['imageUrl'] != null &&
                                        transaction['imageUrl'].isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            transaction['imageUrl']),
                                        radius: 25,
                                      )
                                    : const CircleAvatar(
                                        radius: 25,
                                        child: Icon(Icons.image),
                                      ),
                                const SizedBox(width: 16),

                                // Transaction Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction['to'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatDate(transaction['date']),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Transaction Amount
                                Text(
                                  transaction['amount'] > 0
                                      ? '+\$${transaction['amount']}'
                                      : '-\$${transaction['amount'].abs()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: transaction['amount'] > 0
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
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
          ),
        ],
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
