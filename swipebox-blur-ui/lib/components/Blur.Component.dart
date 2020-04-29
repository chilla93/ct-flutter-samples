import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class BlurComponent extends AnimatedWidget {
  BlurComponent({
    Key key,
    @required this.controller
  }) : super(key: key, listenable: controller);

  final PageController controller;
  final blurTween = <Tween<double>>[Tween(begin: 0, end: 3), Tween(begin: 0, end: 1)];

  double get _pageValue {
    assert(controller != null);
    if(controller.hasClients){
      return controller.page ?? controller.initialPage.toDouble();
    }
    return 0;
  }

  double get _pageTransitionValue {
    if(_pageValue < 0){
      return 0;
    }
    return (_pageValue - _pageValue.floor()).abs();
  }

  @override
  Widget build(BuildContext context) {
    const curve = Curves.slowMiddle;
    
    // final sX = blurTween[0].transform(curve.transform(_pageTransitionValue));
    // final sY = blurTween[1].transform(curve.transform(_pageTransitionValue));
    // print(curve.transform(_pageTransitionValue));
    
    final sX = blurTween[0].transform(sin(curve.transform(_pageTransitionValue) * pi));
    final sY = blurTween[1].transform(sin(curve.transform(_pageTransitionValue) * pi));

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sX, sigmaY: sY),
      child: Container(color: Colors.black.withOpacity(0)),
    );
  }
}