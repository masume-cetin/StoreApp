import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define a soft, neutral color palette
const Color primaryColor = Color(0xFFC0C0C0); // Classic silver
const Color secondaryColor = Color(0xFFF8F9FA); // Soft white/off-white
const Color appBarColor = Color(0xFFFDFDFD); // Clean white for app bar
const Color textColorPrimary = Color(0xFF3C3C3C); // Sleek dark gray
const Color textColorSecondary = Color(0xFF8A8A8A); // Cool silver-gray
const Color borderColor = Color(0xFFB0B0B0); // Metallic border tone
extension OpacityColor on Color {
  Color customOpacity(double opacity) {
    return withAlpha((opacity * 255).toInt());
  }
}
// Define custom text styles using Google Fonts
final TextStyle headlineTextStyle = GoogleFonts.poppins(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: textColorPrimary,
  shadows: [
    Shadow(
      offset: const Offset(1.5, 1.5), // X and Y offset
      blurRadius: 2.0,
      color: Colors.black.customOpacity(0.3),
    ),
  ],
);

final TextStyle outlinedFormTitleTextStyle = GoogleFonts.roboto(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: secondaryColor,
  shadows: [
    Shadow(
      offset: const Offset(1.5, 1.5), // X and Y offset
      blurRadius: 2.0,
      color: Colors.black.customOpacity(0.3),
    ),
  ],
);
final TextStyle bodyTextStyle = GoogleFonts.roboto(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: textColorPrimary,
);

final TextStyle buttonTextStyle = GoogleFonts.lato(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: textColorPrimary,
);

// Paddings
const EdgeInsets loginCompanyTitlePadding = EdgeInsets.only(top: 30);
const EdgeInsets loginCompanyTitlePaddingWeb = EdgeInsets.only(bottom: 120);
const EdgeInsets pageContentPadding = EdgeInsets.only(top: 100);
const EdgeInsets loginFormFieldPadding =
EdgeInsets.symmetric(horizontal: 20, vertical: 10);
const EdgeInsets loginFormFieldTitlePadding =
EdgeInsets.symmetric(horizontal: 20);
const EdgeInsets loginButtonPadding =
EdgeInsets.only(top: 30, right: 20, left: 20);

// Create the main ThemeData object
ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: secondaryColor,
    cardColor: Colors.white,
    hintColor: textColorSecondary,
    brightness: Brightness.light,

    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColorPrimary,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColorPrimary,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColorPrimary,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: secondaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor),
      ),
      hintStyle: const TextStyle(color: textColorSecondary),
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),

    appBarTheme: AppBarTheme(
      color: appBarColor,
      elevation: 1,
      shadowColor: borderColor.customOpacity(0.4),
      iconTheme: const IconThemeData(color: textColorPrimary),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textColorPrimary,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );


}
