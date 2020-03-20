import 'package:flutter/material.dart';

class ThemeColours{
  static Color _Hex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
  static Color TEXT_PRIMARY_COLOUR = Colors.white;
  static Color TEXT_SECONDARY_COLOUR = Colors.grey;
  static Color TEXT_TERNARY_COLOUR = _Hex("#C8C8C8");

  static Color PRIMARY_BACKGROUND_COLOR = _Hex("#2B2B2B");
  static Color SECONDARY_BACKGROUND_COLOR = _Hex("#313335");

  static Color SIDE_BAR_COLOUR = _Hex("#383838");
}