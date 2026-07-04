import 'package:flutter/animation.dart';

/// Motion tokens from DESIGN_SYSTEM.md.
abstract final class AppMotion {
  static const fast = Duration(milliseconds: 200);
  static const standard = Duration(milliseconds: 280);
  static const card = Duration(milliseconds: 320);
  static const morph = Duration(milliseconds: 380);
  static const swipeRelease = Duration(milliseconds: 340);
  static const swipeFly = Duration(milliseconds: 260);

  static const standardCurve = Cubic(0.2, 0.8, 0.2, 1);
  static const bouncyCurve = Cubic(0.34, 1.4, 0.64, 1);
  static const swiftCurve = Cubic(0.25, 1, 0.4, 1);
}
