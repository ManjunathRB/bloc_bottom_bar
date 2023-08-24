import 'package:flutter/material.dart';

ThemeData lightTheme(context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 49, 124, 111)),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 49, 124, 111)),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 183, 234, 219),
  );
}

ThemeData darkTheme(context) {
  return ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 194, 156, 206),
        foregroundColor: Colors.black),
  );
}
