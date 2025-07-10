import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.purple[300]!,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: const Color.fromARGB(255, 186, 104, 200),
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.purple[300]!),
    bodyMedium: TextStyle(color: Colors.purple[300]!),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.purple[300]!,
    onPrimary: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple[300]!,
      foregroundColor: Colors.white,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.purple[300]!, 
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.purple[300]!,
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.purple[300]!),
    bodyMedium: TextStyle(color: Colors.purple[300]!),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.purple[300]!,
    onPrimary: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple[300]!,
      foregroundColor: Colors.black,
    ),
  ),
);
