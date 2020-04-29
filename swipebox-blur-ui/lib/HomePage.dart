import 'dart:math';
import 'dart:ui';

import 'package:ct_swipebox/components/ImageBox.component.dart';
import 'package:flutter/material.dart';

import 'components/Blur.Component.dart';
import 'components/SwipeBox.component.dart';
import 'components/SwipeIndicator.component.dart';

class PageData {
  final String title;
  final String imagePath;

  const PageData(this.title, this.imagePath);
}

class HomePage extends StatelessWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  final _pageViewController = PageController();
  final List<PageData> pageData = const [
    PageData("Summer", "assets/images/landscapes/summer.png"),
    PageData("Spring", "assets/images/landscapes/spring.png"),
    PageData("Autumn", "assets/images/landscapes/fall.png"),
    PageData("Winter", "assets/images/landscapes/winter.png")
  ];

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ImageBoxComponent(controller: _pageViewController, imageList: this.pageData.map((i) => i.imagePath).toList()),
          Positioned.fill(
            child: SwipeBoxComponent(
              controller: _pageViewController, 
              listData: this.pageData.map((i) => i.title).toList()
            ),
          ),
          // IgnorePointer(
          //   child: BlurComponent(controller: _pageViewController)
          // ),
          // BlurComponent(controller: _pageViewController),
          Align(
            alignment: Alignment.bottomCenter,
            child: SwipeIndicatorComponent(controller: _pageViewController, pageCount: this.pageData.length), 
          ),
          Container(
            // color: Colors.yellow,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: Container(
                    // color: Colors.blue,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("TRAVEL GUIDE", style: theme.textTheme.title),
                      )
                    ),
                  )
                ),
                Spacer(
                  flex: 7,
                ),
              ]
            ),
          ),
        ],
      )
    );
  }
}





