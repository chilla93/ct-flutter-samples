import 'dart:math';

import 'package:flutter/material.dart';

class SwipeIndicatorComponent extends AnimatedWidget {
  SwipeIndicatorComponent({
    Key key,
    this.controller,
    @required this.pageCount
  }) : _selectedColorTween = ColorTween(begin: Colors.grey, end: Colors.grey.shade100),
  super(key: key, listenable: controller);

  final PageController controller;
  final int pageCount;
  final ColorTween _selectedColorTween;

  double get _pageValue {
    assert(controller != null);
    if(controller.hasClients){
      return controller.page ?? controller.initialPage.toDouble();
    }
    return 0;
  }

  // int get _pageCount {
  //   assert(controller != null);
  //   if(controller.hasClients){
  //     return 4;
  //   }

  //   return 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: new List<Widget>.generate(pageCount, (i) => (_buildDot(i)))
      ),
    );
  }

  Widget _buildDot(int index) {

    //if currentpage is 2.2 and index 1, the max will be 0
    //if currentpage is 2.2 and index 2, the max will be 0.8
    //if currentpage is 1.8, and index 2, the max will be 0.8
    //if current page is 2.8 and index 2, the max will be 0.8
    final maxValue = max<double>(
      0, 
      1 - (_pageValue - index).abs()
    );

    final color = maxValue > 0 ? 
    _selectedColorTween.transform(Curves.easeIn.transform(maxValue)) 
    : _selectedColorTween.begin;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}