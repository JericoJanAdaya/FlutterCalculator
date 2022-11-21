// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0';

  String temp = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  String history = "";

  Widget buildbutton(String buttonValue, int flexValue) {
    return Expanded(
      flex: flexValue,
      child: Container(
        margin: EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonValue == "AC" ||
                    buttonValue == "%" ||
                    buttonValue == "/" ||
                    buttonValue == "x" ||
                    buttonValue == "-" ||
                    buttonValue == "+"
                ? Color(0xffD8D8D8)
                : (buttonValue == "=" ? Color(0xff72A2C8) : Color(0xffF2F2F2)),
          ),
          onPressed: () {
            setState(() {
              if (buttonValue == 'AC') {
                temp = '0';
                num1 = 0;
                num2 = 0;
                operand = "";
              } else if (buttonValue == '+' ||
                  buttonValue == '-' ||
                  buttonValue == 'x' ||
                  buttonValue == '/' ||
                  buttonValue == '%') {
                num1 = double.parse(output);
                operand = buttonValue;
                temp = '0';
              } else if (buttonValue == '.') {
                if (temp.contains('.')) {
                  return;
                } else {
                  temp = temp + buttonValue;
                }
              } else if (buttonValue == "=") {
                num2 = double.parse(output);

                if (operand == '+') {
                  temp = (num1 + num2).toString();
                } else if (operand == '-') {
                  temp = (num1 - num2).toString();
                } else if (operand == 'x') {
                  temp = (num1 * num2).toString();
                } else if (operand == '/') {
                  temp = (num1 / num2).toString();
                } else if (operand == '%') {
                  temp = (num1 % num2).toString();
                }

                num1 = 0;
                num2 = 0;
                operand = "";
              } else {
                temp = temp + buttonValue;
              }

              setState(() {
                output = double.parse(temp).toString();
              });

              if (buttonValue != 'AC' && buttonValue == '=') {
                history = history + buttonValue;
                history = history + output;
              } else if (buttonValue != 'AC') {
                history = history + buttonValue;
              } else {
                history = '';
              }
            });
          },
          child: Container(
            padding: EdgeInsets.all(15),
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
                  buildbutton("%", 1),
                  buildbutton("/", 1),
                ],
              ),
              Row(
                children: [
                  buildbutton("7", 1),
                  buildbutton("8", 1),
                  buildbutton("9", 1),
                  buildbutton("x", 1),
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
                  buildbutton("=", 2),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
