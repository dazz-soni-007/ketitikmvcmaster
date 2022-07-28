import 'package:flutter/material.dart';

class MyColors {
  static Color themeColorYellow = HexColor.fromHex('#ffde59');
  //static Color themeColorBlack = HexColor.fromHex('#000');
  static Color themeRed = HexColor.fromHex('#fd1717');
  static Color themeColorBlack = HexColor.fromHex('#000');
  static Color themeLightYellow = const Color.fromRGBO(255, 255, 224, 1.0);
  static Color themeColor = const Color.fromRGBO(255, 222, 89, 1.0);
  static Color themeBlackTrans =
      const Color.fromRGBO(10, 10, 10, 0.8470588235294118);

  static Color blankTrans = const Color.fromRGBO(3, 3, 3, 0.7098039215686275);
  static Color whiteTransTrans =
      const Color.fromRGBO(7, 7, 7, 0.6509803921568628);
  static Color themeColorTrans =
      const Color.fromRGBO(255, 222, 89, 0.7058823529411765);
  static Color red = const Color.fromRGBO(255, 222, 89, 0.7058823529411765);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension ListFromMap<Key, Element> on Map<Key, Element> {
  List<T> toList<T>(T Function(MapEntry<Key, Element> entry) getElement) =>
      entries.map(getElement).toList();
}
