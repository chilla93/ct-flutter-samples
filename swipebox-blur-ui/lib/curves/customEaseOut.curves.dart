import 'dart:math';

import 'package:flutter/animation.dart';

class CustomEaseOutCurve extends Curve {
  const CustomEaseOutCurve();

  @override
  double transformInternal(double t) {
    return pow(t, 0.5);
  }
}