import 'package:flutter/material.dart';
import 'package:tensor_flow_app/config/device_size.dart';

class Sizes {
  static const iconSize = 26;
  static const p4 = 4.0;
  static const p8 = 8.0;
  static const p10 = 10.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p15 = 15.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p32 = 32.0;
  static const p34 = 34.0;
  static const p36 = 36.0;
  static const p48 = 48.0;
  static const p64 = 64.0;
}

class GapWidth extends StatelessWidget {
  final int width;
  const GapWidth({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getSize(context, width),
    );
  }
}

class GapHeight extends StatelessWidget {
  final int height;
  const GapHeight({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSize(context, height),
    );
  }
}
