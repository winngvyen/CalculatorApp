import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String input = ""; // Stores user input
  String output = ""; // Stores calculated result
  String operand = ""; // Stores the operator
  int num1 = 0; // First operand
  int num2 = 0; // Second operand

  // Handles button events 
  void onButtonClick(String value) {
    setState(() {
      if (value == "C") {
        // Clear all input and output
        input = "";
        output = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (value == "=") {
        // Perform calculation when '=' is pressed
        num2 = int.parse(input);
        switch (operand) {
          case "+":
            output = (num1 + num2).toString();
            break;
          case "-":
            output = (num1 - num2).toString();
            break;
          case "*":
            output = (num1 * num2).toString();
            break;
          case "/":
            output = num2 == 0 ? "Error" : (num1 ~/ num2).toString();
            break;
        }
        input = ""; // Reset input after calculation
      } else if ("+-*/".contains(value)) {
        // Store the first operand and operator
        num1 = int.parse(input);
        operand = value;
        input = "";
      } else {
        // Append digits to input
        input += value;
      }
    });
  }

  // Creates a button with given text
  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onButtonClick(text),
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Calculator")),
        body: Column(
          children: [
            // Display area for input and output
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(16),
                child: Text(
                  input.isEmpty ? output : input,
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            // Calculator buttons
            Column(
              children: [
                Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")]),
                Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("*")]),
                Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
                Row(children: [buildButton("0"), buildButton("="), buildButton("+")]),
                Row(children: [buildButton("C")]), // Clear button
              ],
            ),
          ],
        ),
      ),
    );
  }
}
