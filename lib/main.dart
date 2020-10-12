import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      expression,
                      style: TextStyle(
                          fontSize: 40.0, color: Colors.deepPurple.shade900),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          numPad('7'),
                          numPad('8'),
                          numPad('9'),
                          numPad('/'),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          numPad('4'),
                          numPad('5'),
                          numPad('6'),
                          numPad('x'),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          numPad('1'),
                          numPad('2'),
                          numPad('3'),
                          numPad('-'),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          numPad('0'),
                          numPad('.'),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Expanded(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white)),
                                padding: const EdgeInsets.all(20),
                                onPressed: () {
                                  if (expression.length > 0) {
                                    setState(() {
                                      expression = expression.substring(
                                          0, expression.length - 1);
                                    });
                                  }
                                },
                                onLongPress: () {
                                  if (expression.length > 0) {
                                    setState(() {
                                      expression = '';
                                    });
                                  }
                                },
                                color: Colors.red.shade900,
                                child: Text(
                                  "<",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                ),

                              ),
                            ),
                          ),
                          numPad('+'),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(270, 3, 2, 2),
                            child: Expanded(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white)),
                                padding: const EdgeInsets.all(20),
                                onPressed: () {
                                  if (expression.contains('x')) {
                                    expression =
                                        expression.replaceAll('x', '*');
                                  }
                                  Parser p = Parser();
                                  Expression exp = p.parse(expression);
                                  ContextModel cm = ContextModel();
                                  double cevap =
                                      exp.evaluate(EvaluationType.REAL, cm);
                                  setState(() {
                                    expression = cevap.toString();
                                  });
                                },
                                color: Colors.deepPurple.shade700,
                                child: Text(
                                  "=",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget numPad(String ch) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Expanded(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.white)),
          padding: const EdgeInsets.all(20),
          onPressed: () {
            setState(() {
              expression += ch;
            });
          },
          color: Colors.white,
          child: Text(
            ch,
            style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 35),
          ),
        ),
      ),
    );
  }
}
