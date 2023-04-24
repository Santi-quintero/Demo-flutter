import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.deepPurple;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: Colors.deepPurple,
      appBarTheme: const AppBarTheme(color: Colors.deepPurple, elevation: 0),
      scaffoldBackgroundColor: Colors.grey[300]
  );
          
}
