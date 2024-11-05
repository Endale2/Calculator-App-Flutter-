import 'package:flutter/material.dart';
import 'calculator_logic.dart';
import 'button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic calculator = CalculatorLogic();
  String displayText = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        displayText = calculator.calculateResult();
      } else if (value == "CLR") {
        calculator.clear();
        displayText = "0";
      } else if (value == "DEL") {
        calculator.deleteLast();
        displayText = calculator.currentInput;
      } else {
        calculator.addInput(value);
        displayText = calculator.currentInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth / 4;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Text(
                  displayText,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            // Button grid
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: ButtonValues.buttonValues.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  final value = ButtonValues.buttonValues[index];
                  return buildButton(value, buttonSize);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String value, double size) {
    Color buttonColor;
    if (value == "CLR" || value == "DEL") {
      buttonColor = Colors.red;
    } else if (value == "=" ||
        value == "+" ||
        value == "-" ||
        value == "×" ||
        value == "÷") {
      buttonColor = Colors.orange;
    } else {
      buttonColor = Colors.grey[200]!;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          onPressed: () => onButtonPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
