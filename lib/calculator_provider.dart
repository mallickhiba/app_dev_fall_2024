import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorProvider extends ChangeNotifier {
  String _display = '0';
  String get display => _display;
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
    } catch (e) {
      _display = 'Error';
    }
    notifyListeners();
  }
}