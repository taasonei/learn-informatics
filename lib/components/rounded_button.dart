import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.buttonText, this.color, @required this.onPressed});
  final String buttonText;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(5.0),
      child: MaterialButton(
        minWidth: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Raleway',
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
