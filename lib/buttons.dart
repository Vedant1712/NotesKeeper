import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key, required this.text, required this.color, this.callback, this.textColor}) : super(key: key);

  final String text;
  final Color color;
  final Color? textColor;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: callback,
        height: 40.0,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20.0,
              color: textColor
          ),
        ),
      ),
    );
  }
}
