import 'package:flutter/material.dart';
// import 'package:iba_course_2/main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
    child: CounterApp(),
  ));
}

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter App'),
        ),
        body: Center(
          child: Consumer<Counter>(
            builder: (context, counter, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Count: ${counter.count}'),
                  ElevatedButton(
                    onPressed: counter.increment,
                    child: Text('Increment'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
