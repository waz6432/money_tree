import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#ED9728");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color darkBlueGrey = HexColor.fromHex("#526A76");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity20 = HexColor.fromHex("#33ED9728");
  static Color primaryOpacity30 = HexColor.fromHex("#4DED9728");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");

  static Color darkPrimary = HexColor.fromHex("#D17D11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#E61F34");

  static Color black = HexColor.fromHex("#000000");
  static Color green = HexColor.fromHex("#3C9C63");
  static Color red = HexColor.fromHex("#E33602");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
