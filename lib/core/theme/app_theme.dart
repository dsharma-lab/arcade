/// GameVault visual theme — dark arcade aesthetic.
///
/// All colors and text styles must come from this file — never hardcode in widgets.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // --- Color Palette ---
  static const kBackground = Color(0xFF0D0D1A);
  static const kSurface = Color(0xFF1A1A2E);
  static const kCard = Color(0xFF16213E);
  static const kAccent = Color(0xFF7C3AED);       // Electric violet
  static const kAccentGlow = Color(0xFFAB7DF8);
  static const kGold = Color(0xFFFFD700);
  static const kTextPrimary = Color(0xFFF1F1F1);
  static const kTextSecondary = Color(0xFF9CA3AF);
  static const kSuccess = Color(0xFF10B981);
  static const kError = Color(0xFFEF4444);

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kBackground,
    primaryColor: kAccent,
    colorScheme: const ColorScheme.dark(
      primary: kAccent,
      secondary: kAccentGlow,
      surface: kSurface,
      error: kError,
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          color: kTextPrimary, fontSize: 48, fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: kTextPrimary, fontSize: 28, fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(color: kTextSecondary, fontSize: 14),
        labelLarge: TextStyle(
          color: kTextPrimary, fontSize: 16, fontWeight: FontWeight.w600,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      color: kCard,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackground,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.bold,
      ),
    ),
  );
}
