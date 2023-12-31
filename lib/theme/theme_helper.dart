import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.gray200,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.lightGreenA400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 3,
        space: 3,
        color: colorScheme.errorContainer.withOpacity(0.6),
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.primaryContainer.withOpacity(0.6),
          fontSize: 17.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 15.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 8.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 25.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 10.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 20.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 18.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFF30D7CD),
    primaryContainer: Color(0XFF3C3C43),
    secondaryContainer: Color(0XFFFFD037),

    // Error colors
    errorContainer: Color(0X3F000000),
    onError: Color(0XFFF9A826),

    // On colors(text colors)
    onPrimary: Color(0XFF1C1B1F),
    onPrimaryContainer: Color(0XFFFFFFFF),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Blue
  Color get blue300 => Color(0XFF5F9DF9);
  Color get blue30001 => Color(0XFF5F9CF8);

  // Cyan
  Color get cyan400 => Color(0XFF30D6CC);

  // DeepOrange
  Color get deepOrange100 => Color(0XFFFFB8B8);

  // Gray
  Color get gray100 => Color(0XFFF2F2F2);
  Color get gray200 => Color(0XFFEEEEEE);
  Color get gray400 => Color(0XFFC4C4C4);
  Color get gray40001 => Color(0XFFC3BEBE);

  // Green
  Color get green700 => Color(0XFF269137);

  // LightGreen
  Color get lightGreenA400 => Color(0XFF5AFF0D);

  // Orange
  Color get orange300 => Color(0XFFF4BC63);

  // Red
  Color get red600 => Color(0XFFEF2121);
  Color get redA400 => Color(0XFFFC1B1B);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
