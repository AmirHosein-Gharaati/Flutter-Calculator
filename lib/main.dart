import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'buttons.dart';
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
    'CE',
    '(',
    ')',
    '%',
    'sin',
    'cos',
    'tan',
    'cot',
    'abs',
    '1',
    '2',
    '3',
    '^',
    '√',
    '4',
    '5',
    '6',
    '×',
    '÷',
    '7',
    '8',
    '9',
    '+',
    '-',
    '+/-',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg/bg.png"), fit: BoxFit.fill),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: double.infinity,
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.dehaze),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.wb_sunny),
                              onPressed: () {},
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          userQuestion,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                child: Container(
                  color: Colors.grey[850],
                  child: StaggeredGridView.countBuilder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: buttons.length,
                      crossAxisCount: 5,
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
                            color: Colors.purple[800],
                            textColor: Colors.white,
                          );
                        }
                        //CE button
                        else if (buttons[index] == "CE") {
                          return MyButton(
                            fontSize: 24.0,
                            buttonTapeed: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.purple[800],
                            textColor: Colors.white,
                          );
                        }
                        //equal button
                        else if (buttons[index] == "=") {
                          return MyButton(
                            fontSize: 50.0,
                            buttonTapeed: () {
                              setState(() {
                                userAnswer = evaluateString();
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.yellow[900],
                            textColor: Colors.white,
                          );
                        } else if (buttons[index] == "+/-") {
                          return MyButton(
                            fontSize: 21.0,
                            buttonTapeed: () {
                              setState(() {
                                userQuestion = addMinus(userQuestion);
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.grey[800],
                            textColor: Colors.white,
                          );
                        }

                        bool isthreealpha = isThreeAlpha(buttons[index]);
                        bool isnumber = isNumber(buttons[index]);
                        bool isoperator = isOperator(buttons[index]);
                        return MyButton(
                            fontSize:
                                isthreealpha ? 21.0 : isoperator ? 32.0 : 28.0,
                            buttonTapeed: () {
                              setState(() {
                                addChar(buttons[index], isthreealpha);
                              });
                            },
                            buttonText: buttons[index],
                            color: isnumber
                                ? Colors.grey[700]
                                : isoperator
                                    ? Colors.purple[800]
                                    : Colors.grey[800],
                            textColor: Colors.white);
                      },
                      staggeredTileBuilder: (int index) {
                        if (buttons[index] == "=") {
                          return StaggeredTile.count(2, 0.87);
                        } else {
                          return StaggeredTile.count(1, 0.87);
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isThreeAlpha(String b) {
    if (b == 'abs' || b == 'sin' || b == 'cos' || b == 'tan' || b == 'cot') {
      return true;
    } else {
      return false;
    }
  }

  bool isOperator(String b) {
    if (b == '^' || b == '+' || b == '-' || b == '×' || b == '√' || b == '÷') {
      return true;
    } else {
      return false;
    }
  }

  bool isNumber(String b) {
    if (b == '0' ||
        b == '1' ||
        b == '2' ||
        b == '3' ||
        b == '4' ||
        b == '5' ||
        b == '6' ||
        b == '7' ||
        b == '8' ||
        b == '9') {
      return true;
    } else {
      return false;
    }
  }

  void addChar(String s, bool isThreeAlpha) {
    if (userQuestion.length <= 25) {
      userQuestion += (isThreeAlpha) ? s + '(' : s;
    }
  }

  String addMinus(String userQuestion) {
    if (userQuestion[0] == '-') {
      userQuestion = userQuestion.substring(1);
    } else {
      if (userQuestion.length <= 25) {
        userQuestion = '-' + userQuestion;
      }
    }
    return userQuestion;
  }

  String evaluateString() {
    String finalQuestion = userQuestion;
    if (finalQuestion == '') {
      return "";
    }
    finalQuestion = finalQuestion.replaceAll('×', '*');
    finalQuestion = finalQuestion.replaceAll('÷', '/');
    finalQuestion = finalQuestion.replaceAll('√', 'sqrt');
    finalQuestion = finalQuestion.replaceAll('cot', '1/tan');

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
        return evalInt.toString();
      } else {
        return eval.toString();
      }
    } catch (e) {
      print(e);
      return "Error";
    }
  }
}
