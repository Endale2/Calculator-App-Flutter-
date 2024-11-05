import 'package:expressions/expressions.dart';

class CalculatorLogic {
  String _currentInput = "";
  bool _resultDisplayed = false;

  String get currentInput => _currentInput.isEmpty ? "0" : _currentInput;

  void addInput(String value) {
    if (_resultDisplayed) {
      _currentInput = "";
      _resultDisplayed = false;
    }
    _currentInput += value;
  }

  void deleteLast() {
    if (_currentInput.isNotEmpty) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
    }
  }

  String calculateResult() {
    try {
      final expression = Expression.parse(
          _currentInput.replaceAll('×', '*').replaceAll('÷', '/'));
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      _resultDisplayed = true;
      _currentInput = result.toString();
      return _currentInput;
    } catch (e) {
      return "Error";
    }
  }

  void clear() {
    _currentInput = "";
    _resultDisplayed = false;
  }
}
