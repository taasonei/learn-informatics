import 'package:flutter/material.dart';

const kAppBarText = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.bold,
);

const kCardTitleText = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w900,
  fontSize: 18.0,
);

const kCardSubtitleText = TextStyle(
  fontFamily: 'Raleway',
  fontSize: 15.0,
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  labelText: '',
  labelStyle: TextStyle(fontFamily: 'Raleway', fontSize: 15.0),
  hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFcfd8dc)),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFcfd8dc)),
  ),
);
