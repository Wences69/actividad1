import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData DarkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade700,
        inversePrimary: Colors.grey.shade500
    ),
    textTheme: GoogleFonts.exo2TextTheme().apply(
        bodyColor: Colors.grey[300],
        displayColor: Colors.white
    )
);