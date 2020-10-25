import 'dart:wasm';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/style/colors.dart' as Style;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Calculator',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      output = "0";
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "D") {
      _output = _output.substring(0, _output.length - 1);
      if (output == "") {
        output = "0";
      }
    } else if (buttonText == "±") {
      num1 = double.parse(_output);
      _output = (num1 * (-1)).toString();
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/" ||
        buttonText == "%") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimals");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "*") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      if (operand == "%") {
        _output = (num1 % num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }
    setState(() {
      output = double.parse(_output).toString();
    });
  }

  buttonCreate(String buttonText) {
    return Expanded(
      child: OutlineButton(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () {
          buttonPressed(buttonText);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Style.Colors.bgcolor,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Divider(),
            ),
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 12.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
//
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buttonCreate("%"),
                    buttonCreate("C"),
                    buttonCreate("D"),
                    buttonCreate("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buttonCreate("7"),
                    buttonCreate("8"),
                    buttonCreate("9"),
                    buttonCreate("*"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buttonCreate("4"),
                    buttonCreate("5"),
                    buttonCreate("6"),
                    buttonCreate("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buttonCreate("1"),
                    buttonCreate("2"),
                    buttonCreate("3"),
                    buttonCreate("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buttonCreate("±"),
                    buttonCreate("0"),
                    buttonCreate("."),
                    buttonCreate("="),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
