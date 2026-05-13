import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Sora for headings, DM Sans for body (matches HTML).
abstract final class AppTextStyles {
  static TextStyle sora({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    double? height,
  }) =>
      GoogleFonts.sora(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColors.textPrimary,
        height: height,
      );

  static TextStyle dmSans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
  }) =>
      GoogleFonts.dmSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColors.textPrimary,
        height: height,
      );

  static TextTheme textTheme() => TextTheme(
        displayLarge: sora(fontSize: 32, fontWeight: FontWeight.w800),
        displayMedium: sora(fontSize: 24, fontWeight: FontWeight.w800),
        displaySmall: sora(fontSize: 22, fontWeight: FontWeight.w800),
        headlineMedium: sora(fontSize: 18, fontWeight: FontWeight.w700),
        titleLarge: sora(fontSize: 16, fontWeight: FontWeight.w700),
        titleMedium: dmSans(fontSize: 14, fontWeight: FontWeight.w600),
        bodyLarge: dmSans(fontSize: 16),
        bodyMedium: dmSans(fontSize: 14),
        bodySmall: dmSans(fontSize: 12, color: AppColors.textSecondary),
        labelLarge: dmSans(fontSize: 14, fontWeight: FontWeight.w600),
        labelSmall: dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted),
      );
}
