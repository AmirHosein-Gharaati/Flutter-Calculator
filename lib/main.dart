import 'package:flutter/material.dart';
import 'buttos.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '6',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        userQuestion,
                        style: TextStyle(fontSize: 20),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        userAnswer,
                        style: TextStyle(fontSize: 20),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    //clear button
                    if (index == 0) {
                      return MyButton(
                        buttonTapeed: () {
                          setState(() {
                            userQuestion = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                      //DEL button
                    } else if (index == 1) {
                      return MyButton(
                        buttonTapeed: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                    //equal button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapeed: () {
                          setState(() {
                            evaluateString();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    }
                    bool isOperatorr = isOperator(buttons[index]);
                    return MyButton(
                      buttonTapeed: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperatorr ? Colors.deepPurple : Colors.white,
                      textColor: isOperatorr ? Colors.white : Colors.deepPurple,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String b) {
    if (b == '+' || b == '-' || b == 'x' || b == '/' || b == '%') {
      return true;
    } else {
      return false;
    }
  }

  void evaluateString() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
