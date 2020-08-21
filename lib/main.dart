import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:number_display/number_display.dart';

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
  final display = createDisplay(length: 12);

  final List<String> buttons = [
    'C',
    '(',
    ')',
    'DEL',
    '%',
    '^',
    '÷',
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
    '.',
    '0',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: double.infinity,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.grey[900],
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        userQuestion,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        color: Colors.grey[900],
                        padding: EdgeInsets.all(15),
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: 45, color: Colors.white),
                        ),
                        alignment: Alignment.centerLeft),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: StaggeredGridView.countBuilder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: buttons.length,
                  crossAxisCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    //C button
                    if (buttons[index] == "C") {
                      return MyButton(
                        fontSize: 28.0,
                        buttonTapeed: () {
                          setState(() {
                            userQuestion = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                    //DEL button
                    else if (buttons[index] == "DEL") {
                      return MyButton(
                        fontSize: 22.0,
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
                    else if (buttons[index] == "=") {
                      return MyButton(
                        fontSize: 28.0,
                        buttonTapeed: () {
                          setState(() {
                            evaluateString();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.indigo[400],
                        textColor: Colors.white,
                      );
                    }
                    bool isOperatorr = isOperator(buttons[index]);
                    return MyButton(
                        fontSize: 28.0,
                        buttonTapeed: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color:
                            isOperatorr ? Colors.yellow[800] : Colors.grey[800],
                        textColor: Colors.white);
                  },
                  staggeredTileBuilder: (int index) {
                    if (buttons[index] == "=" || buttons[index] == "C") {
                      return StaggeredTile.count(2, 0.7);
                    } else {
                      return StaggeredTile.count(1, 0.7);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String b) {
    if (b == '+' || b == '-' || b == 'x' || b == '÷' || b == '%' || b == '^') {
      return true;
    } else {
      return false;
    }
  }

  void evaluateString() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp;
    ContextModel cm = ContextModel();
    double eval;
    int evalInt;

    try {
      exp = p.parse(finalQuestion);
      eval = exp.evaluate(EvaluationType.REAL, cm);
      if (eval == eval.toInt()) {
        evalInt = eval.toInt();
        userAnswer = display(evalInt).toString();
      } else {
        userAnswer = display(eval).toString();
      }
    } catch (e) {
      print(e);
      userAnswer = "Invalid";
    }
  }
}
