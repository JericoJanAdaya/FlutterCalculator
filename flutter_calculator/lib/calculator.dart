// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String history = "0";
  String output = "0";
  String expression = "";

  Widget buildbutton(String buttonValue, int flexValue) {
    return Expanded(
      flex: flexValue,
      child: Container(
        margin: EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonValue == "AC" ||
                    buttonValue == "C" ||
                    buttonValue == "%" ||
                    buttonValue == "/" ||
                    buttonValue == "*" ||
                    buttonValue == "-" ||
                    buttonValue == "+"
                ? Color(0xffD8D8D8)
                : (buttonValue == "=" ? Color(0xff72A2C8) : Color(0xffF2F2F2)),
          ),
          onPressed: () {
            setState(() {
              if (buttonValue == "AC") {
                history = "0";
                output = "0";
              } else if (buttonValue == "C") {
                history = history.substring(0, history.length - 1);
                if (history == "") {
                  history = "0";
                }
              } else if (buttonValue == "=") {
                expression = history;
                try {
                  Parser p = Parser();
                  Expression exp = p.parse(expression);
                  ContextModel cm = ContextModel();
                  output = '${exp.evaluate(EvaluationType.REAL, cm)}';
                  history = output;
                } catch (e) {
                  output = "Error";
                }
              } else {
                if (history == "0") {
                  history = buttonValue;
                } else {
                  history = history + buttonValue;
                }
              }
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Text(
              buttonValue,
              style: TextStyle(fontSize: 30, color: Color(0xff000000)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC2C4C5),
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(
            color: Color(0xff000000),
            fontSize: 30,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffC2C4C5),
      ),
      body: ListView(
        children: [
          Expanded(
            child: Divider(),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.5),
            child: Text(
              history,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff4E4E4E),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(12.5, 12.5, 12.5, 25),
            child: Text(
              output,
              style: TextStyle(
                fontSize: 40,
                color: Color(0xff000000),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildbutton("AC", 2),
                  buildbutton("C", 1),
                  buildbutton("%", 1),
                  buildbutton("/", 1),
                ],
              ),
              Row(
                children: [
                  buildbutton("7", 1),
                  buildbutton("8", 1),
                  buildbutton("9", 1),
                  buildbutton("*", 1),
                ],
              ),
              Row(
                children: [
                  buildbutton("4", 1),
                  buildbutton("5", 1),
                  buildbutton("6", 1),
                  buildbutton("-", 1),
                ],
              ),
              Row(
                children: [
                  buildbutton("1", 1),
                  buildbutton("2", 1),
                  buildbutton("3", 1),
                  buildbutton("+", 1),
                ],
              ),
              Row(
                children: [
                  buildbutton("0", 1),
                  buildbutton(".", 1),
                  buildbutton("00", 2),
                  buildbutton("=", 1),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
