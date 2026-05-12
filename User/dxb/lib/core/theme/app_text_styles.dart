import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography: Sora (display) + DM Sans (body) per design reference.
abstract final class AppTextStyles {
  static TextStyle displayXs({Color? color}) => GoogleFonts.sora(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: color ?? AppColors.onSurface3,
      );

  static TextStyle displaySm({Color? color, FontWeight? weight}) =>
      GoogleFonts.sora(
        fontSize: 14,
        fontWeight: weight ?? FontWeight.w700,
        color: color ?? AppColors.onSurface,
      );

  static TextStyle displayMd({Color? color, FontWeight? weight}) =>
      GoogleFonts.sora(
        fontSize: 17,
        fontWeight: weight ?? FontWeight.w800,
        color: color ?? AppColors.onSurface,
      );

  static TextStyle displayLg({Color? color, FontWeight? weight}) =>
      GoogleFonts.sora(
        fontSize: 20,
        fontWeight: weight ?? FontWeight.w800,
        height: 1.2,
        color: color ?? AppColors.onSurface,
      );

  static TextStyle displayXl({Color? color, FontWeight? weight}) =>
      GoogleFonts.sora(
        fontSize: 26,
        fontWeight: weight ?? FontWeight.w800,
        height: 1.2,
        letterSpacing: -0.02 * 26,
        color: color ?? AppColors.onSurface,
      );

  static TextStyle displayHero({Color? color}) => GoogleFonts.sora(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.03 * 38,
        color: color ?? AppColors.onSurface,
      );

  static TextStyle bodySm({Color? color, FontWeight? weight}) =>
      GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: weight ?? FontWeight.w500,
        color: color ?? AppColors.onSurface3,
      );

  static TextStyle bodyMd({Color? color, FontWeight? weight}) =>
      GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: weight ?? FontWeight.w500,
        height: 1.5,
        color: color ?? AppColors.onSurface2,
      );

  static TextStyle bodyLg({Color? color, FontWeight? weight}) =>
      GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: weight ?? FontWeight.w500,
        height: 1.6,
        color: color ?? AppColors.onSurface,
      );

  static TextStyle button({Color? color}) => GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: color ?? Colors.white,
      );

  static TextStyle chip({Color? color, bool active = false}) =>
      GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.onSurface2,
      );

  static TextStyle navLabel({Color? color, FontWeight? weight}) =>
      GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: weight ?? FontWeight.w500,
        color: color ?? AppColors.onSurface3,
      );
}
