
import 'package:flutter/material.dart';
import 'package:flutter_first/src/components/AppDrawerComponent.dart';
import 'package:flutter_first/src/pages/HomePage.dart';
import 'package:flutter_first/src/partials/DrawerContentPartial.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return AppDrawerContainer(
    //   drawerContentChild: DrawerContentPartial(),
    //   child: HomePage()
    // );

    return AppDrawerController(
      widthFactor: 0.5,
      drawerContentChild: DrawerContentPartial(),
      child: HomePage()
    );
  }


}
