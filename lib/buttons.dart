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
      padding: const EdgeInsets.all(5.0),
      child: RaisedButton(
        splashColor: Colors.lightBlue,
        onPressed: buttonTapeed,
        animationDuration: Duration(seconds: 1),
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        color: color,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: textColor, fontSize: fontSize, fontFamily: 'Raleway'),
          ),
        ),
      ),
    );
  }
}
