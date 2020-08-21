import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapeed;
  final fontSize;

  MyButton(
      {this.color,
      this.textColor,
      this.buttonText,
      this.buttonTapeed,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            color: color,
            child: RaisedButton(
              highlightColor: Colors.lightBlue,
              onPressed: buttonTapeed,
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor, fontSize: fontSize),
                ),
              ),
            ),
          )),
    );
  }
}
