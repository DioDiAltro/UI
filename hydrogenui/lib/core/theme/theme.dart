import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrogenui/core/theme/palette.dart';

// Dark Theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  fontFamily: GoogleFonts.kodeMono.toString(),

  scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
  iconTheme: const IconThemeData(color: Palette.primaryColor),

  colorScheme: const ColorScheme.dark(
    primary: Palette.primaryColor,
    secondary: Palette.secondaryColor,
    surface: Palette.scaffoldBackgroundColor,
    onPrimary: Color(0xFF522820),
    onSecondary: Color(0xFF012834),
  ),

  buttonTheme: const ButtonThemeData(
    buttonColor: Palette.primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
);
