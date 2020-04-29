import 'package:flutter/material.dart';
import 'package:flutter_first/src/components/ShoeItemComponent.dart';
import 'package:flutter_first/src/components/HeaderComponent.dart';
import 'package:flutter_first/src/data/Shoes.dart';
import 'package:flutter_first/src/partials/DetailsBannerPartial.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Welcome"),
      drawerScrimColor: Colors.black54,
      body: LayoutBuilder(
        builder: (context, constraints) => (ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16).copyWith(top: 40),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: DetailsBannerPartial(),
                    ),
                  ]
                  ..addAll(
                    shoesList.map((item) => (
                      ShoeItem(item: item)
                    ))
                  ),
                ),
              ),
            ))),
      ),
    );
  }
}