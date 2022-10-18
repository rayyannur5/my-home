import 'package:flutter/material.dart';

class AppColor {
  static Color bg() => Colors.white;
  // var bg = Colors.white;
}

class AppStyles {
  var headline1 = const TextStyle(fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.w900);
  var headline2 = const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w900);
  var headline2_regular = const TextStyle(fontFamily: 'Poppins', fontSize: 20);
  var headline2_regular_dark = const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 20);
  var headline1_dark =
      const TextStyle(fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.w900, color: Colors.white);
  var headline2_dark =
      const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white);
  var headline2_thin_dark =
      const TextStyle(fontFamily: 'Poppins', fontSize: 30, fontWeight: FontWeight.w100, color: Colors.white);
  // var headline3 =
  // TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);
  var paragraph = const TextStyle(fontFamily: 'Poppins', fontSize: 15);
  var paragraph_thin = const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w300);
  var paragraph_dark = const TextStyle(fontFamily: 'Poppins', fontSize: 15, color: Colors.white);
  var paragraph_bold = const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700);
  var paragraph_bold_dark =
      const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);
  var miniparagraph = const TextStyle(fontFamily: 'Poppins', fontSize: 12);
  var miniparagraph_thin = const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w300);
  var miniparagraph_dark = const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white);
  var miniparagraph_thin_dark =
      const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300);
  var subtitle1 = const TextStyle(fontFamily: 'Poppins', fontSize: 15, color: Colors.grey);
  var subtitle2 = const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey);
  var textButton = const TextStyle(fontFamily: 'Poppins', fontSize: 15, color: Colors.white);
  var buttonStyle = ButtonStyle(
      elevation: const MaterialStatePropertyAll(0),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))));
}
