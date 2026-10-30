import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Authentic Palette from WhatsApp Mocks & Spec
  static const Color ivoryBackground = Color(0xFFFAF6EE);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color crimsonMaroon = Color(0xFF8B1E2D);
  static const Color deepCrimson = Color(0xFF701322);
  static const Color royalGold = Color(0xFFC59B27);
  static const Color primaryGold = Color(0xFFC59B27);
  static const Color lightGold = Color(0xFFF3E5AB);
  static const Color deepGold = Color(0xFFAA8010);
  static const Color goldBorder = Color(0xFFE2C974);
  static const Color goldCardFill = Color(0xFFFBF7EC);
  static const Color marigoldOrange = Color(0xFFEA580C);
  static const Color marigoldYellow = Color(0xFFF59E0B);
  static const Color textDark = Color(0xFF1E232A);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color textMuted = Color(0xFF64748B);
  static const Color greenVerified = Color(0xFF16A34A);
  static const Color accentEmerald = Color(0xFF16A34A);
  static const Color accentRose = Color(0xFFE2847A);
  static const Color surfaceCard = Color(0xFFFDFBF7);
  static const Color surfaceCardElevated = Color(0xFFF8F3E6);
  static const Color darkSurface = Color(0xFF1A2130);
  static const Color darkBackground = Color(0xFF0C101C);

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFE8C86A), Color(0xFFC59B27), Color(0xFFA67C1E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient maroonGradient = LinearGradient(
    colors: [Color(0xFF991B1B), Color(0xFF8B1E2D), Color(0xFF701322)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get festiveLightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: ivoryBackground,
      primaryColor: crimsonMaroon,
      colorScheme: const ColorScheme.light(
        primary: crimsonMaroon,
        secondary: royalGold,
        surface: surfaceWhite,
        onPrimary: Colors.white,
        onSurface: textDark,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cinzel(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: crimsonMaroon,
          letterSpacing: 1.0,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        displaySmall: GoogleFonts.cinzel(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: crimsonMaroon,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: textDark,
          height: 1.4,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: textMuted,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.outfit(
          fontSize: 11,
          fontWeight: FontWeight.normal,
          color: textMuted,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFEBDAB0), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDCD5C5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDCD5C5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: crimsonMaroon, width: 1.5),
        ),
        hintStyle: GoogleFonts.outfit(color: textMuted, fontSize: 13),
      ),
    );
  }
}
