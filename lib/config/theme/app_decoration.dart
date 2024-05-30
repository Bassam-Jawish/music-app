import 'package:flutter/material.dart';

class AppDecoration {
  // Gradient decorations
  static Gradient get primaryGradient => LinearGradient(colors: [
        Color(0xFF403151).withOpacity(0.6),
        Color(0xFF403151).withOpacity(0.9),
      ]);

  static Gradient get profileGradient => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.5),
            Color(0xFF31314F).withOpacity(1),
            Color(0xFF31314F).withOpacity(1),
          ]);
}
