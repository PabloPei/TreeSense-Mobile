import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle titleStyle = GoogleFonts.raleway(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle captionTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle bottomTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle errorTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  );

  static const TextStyle buttonNegativeTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle userLabelStyle = GoogleFonts.quicksand(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle userValueStyle = GoogleFonts.quicksand(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle developersMessageStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: Colors.grey,
  );
}
