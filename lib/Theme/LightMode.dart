import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData LightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade500
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black
  )
);