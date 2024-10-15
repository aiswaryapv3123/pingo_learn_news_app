import 'package:flutter/cupertino.dart';

extension SizeExtensions on BuildContext {
  double get widthPx => MediaQuery.of(this).size.width;
  double get heightPx => MediaQuery.of(this).size.height;
  double heightFct(double fraction) => heightPx * fraction;
  double widthFct(double fraction) => widthPx * fraction;
}
