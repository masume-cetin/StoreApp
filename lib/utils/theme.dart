import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define custom colors
const Color primaryColor = Color(0xFF00BFAE); // Example primary color
const Color secondaryColor = Color(0xFF03DAC6); // Example secondary color
const Color appBarColor = Color(0xFF1F1F1F); // Dark color for AppBar

// Define custom text styles using Google Fonts
final TextStyle headlineTextStyle = GoogleFonts.poppins(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

final TextStyle bodyTextStyle = GoogleFonts.roboto(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.black87,
);

final TextStyle buttonTextStyle = GoogleFonts.lato(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

// Paddings

const EdgeInsets loginCompanyTitlePadding = EdgeInsets.only(bottom: 80);
const EdgeInsets loginCompanyTitlePaddingWeb = EdgeInsets.only(bottom: 120);
const EdgeInsets pageContentPadding = EdgeInsets.only(top: 100);
const EdgeInsets loginFormFieldPadding =
    EdgeInsets.symmetric(horizontal: 20, vertical: 10);
const EdgeInsets loginFormFieldTitlePadding =
    EdgeInsets.symmetric(horizontal: 20);
const EdgeInsets loginButtonPadding =
    EdgeInsets.only(top: 30, right: 20, left: 20);

// Create the main ThemeData object using Google Fonts
ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    hintColor: secondaryColor,
    brightness: Brightness.light,

    // TextTheme for headings, body text, etc.
    textTheme: TextTheme(
      headlineLarge: headlineTextStyle, // Headlines
      bodyMedium: bodyTextStyle, // Body text
      labelMedium: buttonTextStyle, // Buttons
    ),

    // Button theme
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),

    // AppBar theme customization
    appBarTheme: AppBarTheme(
      color: appBarColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    // Scaffold background color
    scaffoldBackgroundColor: Colors.white,

    // Floating action button theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),

    // Visual density for better UI scaling
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
