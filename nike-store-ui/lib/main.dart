
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/src/Layouts/DefaultLayout.dart';
import 'package:flutter_first/src/pages/HomePage.dart';
// import 'package:sleeper/sleeper.dart';
import './theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.black, // navigation bar color
    //   statusBarColor: Colors.black, // status bar color
    //   statusBarIconBrightness: Brightness.light,
    //   systemNavigationBarIconBrightness: Brightness.light
    // ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.yellow,
      //   fontFamily: "Work Sans"
      // ),
      theme: generalAppTheme,
      home: DefaultLayout(),
    );
  }
}


