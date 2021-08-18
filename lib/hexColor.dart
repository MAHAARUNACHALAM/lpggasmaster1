import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color b = HexColor("#3E4EE3");
Color gr = HexColor("#E6E6E6");
Color lb = HexColor("#EBF6FF");
Color o = HexColor("#FF5100");
Color dg = HexColor('#388581');
// Color gr = HexColor('#edeeed');
Color yo = HexColor('#f0ad4b');
Color br = HexColor('#855f2a');
Color v = HexColor('#2a2946');
// Color lb = HexColor("#85c1e5");
