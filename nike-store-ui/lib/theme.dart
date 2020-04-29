import 'dart:ui';

import 'package:flutter/material.dart';



  class AppColors {
    static MaterialColor primary = MaterialColor(
      _pColor.value,
      <int, Color>{
        50:  _pColorLight.withOpacity(0.5),
        100: _pColorLight.withOpacity(0.8),
        200: _pColorLight,
        300: _pColor.withOpacity(0.5),
        400: _pColor.withOpacity(0.8),
        500: _pColor,
        600: _pColorDark.withOpacity(0.5),
        700: _pColorDark.withOpacity(0.8),
        800: _pColorDark,
        900: _pColorDark,
      },
    );

    // static const Color _accentColor = Color(0xFFC94D49);
    static const Color _accentColor = Color(0xFFF6695C);
    static const Color _pColor = Color(0xFF201c34);
    static const Color _pColorDark = Color(0xFF00000e);
    static const Color _pColorLight = Color(0xFF48435e);
  }

  final textTheme = TextTheme(
    display4: TextStyle(color: AppColors._pColor),
    display3: TextStyle(color: AppColors._pColor),
    display2: TextStyle(color: AppColors._pColor),
    display1: TextStyle(color: AppColors._pColor, fontWeight: FontWeight.bold),
    headline: TextStyle(color: AppColors._pColor, fontWeight: FontWeight.bold),
    title: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
    subhead: TextStyle(color: Colors.grey[500]),
    body2: TextStyle(color: Colors.grey[700]),
    body1: TextStyle(color: Colors.grey[700]),
    caption: TextStyle(color: Colors.black),
    button: TextStyle(color: Colors.black),
    subtitle: TextStyle(color: Colors.black),
    overline: TextStyle(color: Colors.black)
  );

  TextTheme generateTextTheme({Color headerColor, Color bodyColor, Color titleColor}){
    var t = textTheme;

    if(headerColor != null){
      t = t.copyWith(
        display4: TextStyle(color: headerColor),
        display3: TextStyle(color: headerColor),
        display2: TextStyle(color: headerColor),
        display1: TextStyle(color: headerColor),
        headline: TextStyle(color: headerColor),
      );
    }


    if(titleColor != null){
      t = t.copyWith(
        title: TextStyle(color: titleColor),
        subhead: TextStyle(color: titleColor),
      );
    }

    if(bodyColor != null){
      t = t.copyWith(
        body2: TextStyle(color: bodyColor),
        body1: TextStyle(color: bodyColor),
        caption: TextStyle(color: bodyColor),
        button: TextStyle(color: bodyColor),
        subtitle: TextStyle(color: bodyColor),
        overline: TextStyle(color: bodyColor)
      );
    }


    return t;
  }



  final generalAppTheme = ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primarySwatch: AppColors.primary,
    // primaryColor: AppColors._pColor,
    accentColor: AppColors._accentColor,
    scaffoldBackgroundColor: Colors.grey[50],
    // backgroundColor: Colors.grey[900],
    cardColor: Colors.grey[200],
    textTheme: generateTextTheme(),
    primaryTextTheme: generateTextTheme(headerColor: Colors.white, titleColor: Colors.white, bodyColor: Colors.white),
    accentTextTheme: generateTextTheme(headerColor: Colors.white, titleColor: Colors.white, bodyColor: Colors.white),
    iconTheme: IconThemeData(color: Colors.grey[200], size: 50),
    primaryIconTheme: IconThemeData(color: Colors.grey[500], size: 30),
    // accentIconTheme: IconThemeData(color: AppColors._accentColor, size: 50),
    appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0, textTheme: generateTextTheme()),    
    fontFamily: "Work Sans",
    
  );
