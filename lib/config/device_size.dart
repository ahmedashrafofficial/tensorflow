import 'package:flutter/material.dart';

extension DeviceSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

const deviceWidth = 360;
const deviceHeight = 640;

double getSize(BuildContext context, int value) {
  return (context.width * context.height) /
      (deviceWidth * deviceHeight) *
      value;
}

double getPadding(BuildContext context) {
  return getSize(context, 16);
}

double getBorderRadius(BuildContext context) {
  return getSize(context, 10);
}
