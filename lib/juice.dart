import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/bloc/juice_bloc/juice_bloc.dart';
import 'package:flutter/material.dart';

class JuicePage extends StatelessWidget {
  const JuicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Details',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 197, 121, 146),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Expanded(
            child: BlocBuilder<JuiceBloc, JuiceState>(
              builder: (context, state) {
                if (state is JuiceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JuiceLoaded) {
                  final juices = state.juice;
                  return ListView.builder(
                    itemCount: juices.length,
                    itemBuilder: (context, index) {
                      final juice = juices[index];
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
                                Image.asset(
                                  'assets/juice.png',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 16),

                                // Juice Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        juice['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        juice['grams'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        (juice['rating'] as double)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        (juice['reviews'] as double)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        juice['description'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'Delivery Time',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            iconColor: Colors.pink),
                                        child: const Text(
                                          'Add to cart',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        juice['delivery_time'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Total Price',
                                        style: const TextStyle(
                                          fontSize: 7,
                                        ),
                                      ),
                                      Text(
                                        (juice['price'] as double)
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is JuiceError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('No juices found.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
