import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

class two extends StatefulWidget {
  @override
  _twoState createState() => _twoState();
}

class _twoState extends State<two> {
  String equation = "0";
  String result = "0";
  String expression = "";

  TextEditingController red = TextEditingController();

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        red.text = equation;
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        red.text = equation;
        if (equation == "") {
          equation = "0";
          red.text = equation;
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
          red.text = equation;
        } else {
          equation = equation + buttonText;
          red.text = equation;
        }
      }
    });
  }

  Widget defaultButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      margin: EdgeInsets.all(7),
      height: MediaQuery.of(context).size.height * 0.09 * buttonHeight,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(20)),
      child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: buttonText == "C" || buttonText == "="
                    ? Colors.white
                    : Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.3,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(15),
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      equation,
                      style: TextStyle(fontSize: 45),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 15),
                    child: Text(
                      result.characters.last == "0"
                          ? result.split(".")[0]
                          : result,
                      style: TextStyle(fontSize: 70),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    color: Colors.grey.withOpacity(0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * .70,
                          child: Table(
                            children: [
                              TableRow(children: [
                                defaultButton("C", 1, Colors.red),
                                defaultButton("⌫", 1, Colors.amber),
                                defaultButton("÷", 1, Colors.blue),
                              ]),
                              TableRow(children: [
                                defaultButton("7", 1, Colors.green),
                                defaultButton("8", 1, Colors.green),
                                defaultButton("9", 1, Colors.green),
                              ]),
                              TableRow(children: [
                                defaultButton("4", 1, Colors.green),
                                defaultButton("5", 1, Colors.green),
                                defaultButton("6", 1, Colors.green),
                              ]),
                              TableRow(children: [
                                defaultButton("1", 1, Colors.green),
                                defaultButton("2", 1, Colors.green),
                                defaultButton("3", 1, Colors.green),
                              ]),
                              TableRow(children: [
                                defaultButton(".", 1, Colors.green),
                                defaultButton("0", 1, Colors.green),
                                defaultButton("00", 1, Colors.green),
                              ]),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          child: Table(
                            children: [
                              TableRow(children: [
                                defaultButton("×", 1, Colors.blue),
                              ]),
                              TableRow(children: [
                                defaultButton("-", 1, Colors.blue),
                              ]),
                              TableRow(children: [
                                defaultButton("+", 1, Colors.blue),
                              ]),
                              TableRow(children: [
                                defaultButton("=", 2.2, Colors.amber),
                              ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
