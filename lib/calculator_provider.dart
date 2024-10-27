import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorProvider extends ChangeNotifier {
  String _display = '0';
   List<String> _history = [];

  String get display => _display;
  List<String> get history => _history;

  void setValue(String value) {
    if (_display == '0' && value != "=") {
      _display = value;
    } else {
      switch (value) {
        case "AC":
          _display = '0';
          break;
        case "x":
          _display += "*";
          break;
        case "=":
          compute();
          break;
        default:
          _display += value;
      }
    }
    notifyListeners();
  }
  void compute() {
    try {
      String expression = _display.replaceAll("x", "*");
      num result = expression.interpret();
      _display = result == result.toInt()
          ? result.toInt().toString()
          : result.toString();
      _history.insert(0, "$expression = $_display"); //add to history list
    } catch (e) {
      _display = 'Error';
    }
    notifyListeners();
  }
}