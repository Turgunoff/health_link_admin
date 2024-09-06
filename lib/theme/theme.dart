import 'package:flutter/material.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF0165FC),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor:
        Color(0xFF0165FC), // Use non-const Color here for flexibility
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
    iconTheme: IconThemeData(
        color: Colors.white), // Remove const for potential future customization
  ),
  textTheme: const TextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.grey[600],
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  ).copyWith(
    secondary: Colors.blue[200],
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey[300],
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue[400],
  scaffoldBackgroundColor: Colors.grey[800],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900], // Slightly darker for better contrast
    titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.grey[400],
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  ).copyWith(
    secondary: Colors.blue[700],
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey[700],
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);
