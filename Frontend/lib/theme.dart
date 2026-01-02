import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff3B82F6),
    onPrimary: Colors.blue,
    secondary: Colors.white,
    onSecondary: Colors.white,
    tertiary: Colors.black87,
    onTertiary: Colors.black,
    error: Colors.red,
    onError: Colors.red,
    surface: Color(0xffF8FAFC),
    onSurface: Colors.blue.shade50,
    outline: Color(0xffE2E8F0),
    scrim: Colors.black54,
    shadow: Color.fromARGB(12, 15, 23, 42),
    tertiaryFixed: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff3B82F6),
    onPrimary: Colors.blue,
    secondary: Color(0xff1E293B),
    onSecondary: Colors.black,
    tertiary: Color(0xffE5E7EB),
    onTertiary: Colors.white,
    error: Colors.red,
    onError: Colors.red,
    surface: Color(0xff0F172A),
    onSurface: Colors.blue.shade200,
    outline: Color(0xff334155),
    scrim: Colors.white54,
    shadow: Color.fromARGB(12, 15, 23, 42),
    tertiaryFixed: Color(0xffE5E7EB),
  ),
);