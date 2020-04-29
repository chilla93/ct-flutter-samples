
import 'package:flutter/material.dart';

ThemeData appTheme () {
  return ThemeData
    .light()
    .copyWith(
      scaffoldBackgroundColor: Colors.grey.shade100,
      textTheme: TextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      )
    );
}

