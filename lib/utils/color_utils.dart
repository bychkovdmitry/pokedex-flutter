import 'package:flutter/material.dart';

class ColorUtils {

  // Returns a color for the given string
  static Color getColor(String str) {
    return Colors.primaries[str.hashCode % Colors.primaries.length];
  }
}
