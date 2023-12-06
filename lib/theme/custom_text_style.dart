import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargePoppinsErrorContainer =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
        fontSize: 18.fSize,
      );
  static get bodyMediumPoppins => theme.textTheme.bodyMedium!.poppins.copyWith(
        fontSize: 13.fSize,
      );
  static get bodyMediumPoppins13 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        fontSize: 13.fSize,
      );
  static get bodyMediumPoppinsBlue300 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.blue300,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumPoppinsLight =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumPoppinsLight13 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumPoppinsLight_1 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        fontWeight: FontWeight.w300,
      );
  static get bodySmall11 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 11.fSize,
      );
  static get bodySmall11_1 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 11.fSize,
      );
  static get bodySmallInter => theme.textTheme.bodySmall!.inter.copyWith(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallInterPrimary => theme.textTheme.bodySmall!.inter.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallOnPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallRegular => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallRegular12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  // Headline text style
  static get headlineSmallPoppins =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallPoppinsBold =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallPoppinsOnError =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLarge13 => theme.textTheme.labelLarge!.copyWith(
        fontSize: 13.fSize,
      );
  static get labelLargeOnError => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 13.fSize,
      );
  static get labelLargeOrange300 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.orange300,
        fontSize: 13.fSize,
      );
  static get labelLargeOrange300SemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.orange300,
        fontWeight: FontWeight.w600,
      );
  static get labelMediumBold => theme.textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get labelMediumBold_1 => theme.textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  // Poppins text style
  static get poppinsErrorContainer => TextStyle(
        color: theme.colorScheme.errorContainer.withOpacity(0.8),
        fontSize: 7.fSize,
        fontWeight: FontWeight.w300,
      ).poppins;
  static get poppinsErrorContainerRegular => TextStyle(
        color: theme.colorScheme.errorContainer.withOpacity(1),
        fontSize: 7.fSize,
        fontWeight: FontWeight.w400,
      ).poppins;
  // Title text style
  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleMediumCyan400 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.cyan400,
      );
  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmall15 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 15.fSize,
      );
  static get chapterLarge =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallInter => theme.textTheme.titleSmall!.inter;
}

extension on TextStyle {
  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
