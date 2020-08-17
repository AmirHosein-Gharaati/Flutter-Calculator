import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapeed;

  MyButton({this.color, this.textColor, this.buttonText, this.buttonTapeed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapeed,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor, fontSize: 25.0),
                ),
              ),
            )),
      ),
    );
  }
}
