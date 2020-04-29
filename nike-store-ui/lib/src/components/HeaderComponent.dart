import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/src/components/AppDrawerComponent.dart';

import 'AppAvatar.dart';

class Header extends AppBar {
  Header({Key key, @required String title, String image}): super(
    key: key,
    leading: _buildLeadingIcon(),
    title: _buildTitle(title),
    actions: _buildActions()
  );

  static Widget _buildLeadingIcon() {
    return Builder(builder: (context) => (
      InkWell(
          customBorder: CircleBorder(),
          onTap: () => AppDrawerController.of(context).toggle(),
          child: Icon(
            Icons.menu,
          ),
      )
    ));

  }

  static Widget _buildTitle(String title){
    return Text(title);
  }

  static List<Widget> _buildActions(){
    return <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: AppAvatar(),
            ),
          ),
        ];
  }

}

