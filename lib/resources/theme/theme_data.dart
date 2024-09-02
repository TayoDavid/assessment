import 'package:assessment/resources/utils/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: bluePrimary,
    secondary: blueSecondary,
    onPrimary: kWhite,
    onSecondary: bluePrimary,
    error: redText,
    onError: kWhite,
    background: kWhite,
    onBackground: kBlack,
    surface: greyInput,
    onSurface: greyDark,
    surfaceVariant: kWhite,
    tertiary: bluePrimary,
    onTertiary: kWhite,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: bluePrimary,
    titleTextStyle: TextStyle(color: bluePrimary),
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: TextTheme(
    displaySmall: headerStyle.copyWith(color: kBlack, fontSize: 20),
    displayMedium: headerStyle.copyWith(color: kBlack, fontSize: 22),
    displayLarge: headerStyle.copyWith(
        color: kBlack, fontSize: 36, fontWeight: FontWeight.w800),
    headlineSmall: headerStyle.copyWith(
        color: kBlack, fontSize: 16, fontWeight: FontWeight.w800),
    headlineMedium: headerStyle.copyWith(
        color: kBlack, fontSize: 20, fontWeight: FontWeight.w800),
    headlineLarge: headerStyle.copyWith(
        color: kBlack, fontSize: 24, fontWeight: FontWeight.w800),
    labelSmall: textStyle.copyWith(color: greyTitle, fontSize: 14),
    labelMedium: textStyle.copyWith(color: greyTitle, fontSize: 16),
    labelLarge: textStyle.copyWith(color: greyTitle, fontSize: 18),
    bodySmall: textStyle.copyWith(color: kBlack, fontSize: 14),
    bodyMedium: textStyle.copyWith(color: kBlack, fontSize: 16),
    bodyLarge: textStyle.copyWith(color: kBlack, fontSize: 18),
    titleSmall: textStyle.copyWith(
        color: greySubtitle, fontSize: 10, fontWeight: FontWeight.normal),
    titleMedium: textStyle.copyWith(
        color: greySubtitle, fontSize: 12, fontWeight: FontWeight.w500),
    titleLarge: textStyle.copyWith(
        color: greySubtitle, fontSize: 14, fontWeight: FontWeight.w500),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: greyInput,
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    hintStyle: TextStyle(
        color: kIndicatorColor, fontSize: 14, fontWeight: FontWeight.w500),
    filled: true,
    border: border,
    enabledBorder: border,
    focusedBorder: OutlineInputBorder(
      borderRadius: kBorderRadius,
      borderSide: BorderSide(color: greyDark, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: kBorderRadius,
      borderSide: BorderSide(color: redErrorBorder, width: 1),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    surfaceTintColor: Colors.transparent,
    elevation: 5,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: greyDark,
    secondary: greySubtitle,
    onPrimary: kWhite,
    onSecondary: greyDark,
    error: redText,
    onError: kWhite,
    background: kBlack,
    onBackground: kWhite,
    surface: greyDark,
    onSurface: greyInput,
    surfaceVariant: greyDark,
    tertiary: kWhite,
    onTertiary: kBlack,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: kWhite,
    titleTextStyle: TextStyle(color: kWhite),
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: TextTheme(
    displaySmall: headerStyle.copyWith(color: kWhite, fontSize: 20),
    displayMedium: headerStyle.copyWith(color: kWhite, fontSize: 22),
    displayLarge: headerStyle.copyWith(
        color: kWhite, fontSize: 36, fontWeight: FontWeight.w800),
    headlineSmall: headerStyle.copyWith(
        color: kWhite, fontSize: 16, fontWeight: FontWeight.w800),
    headlineMedium: headerStyle.copyWith(
        color: kWhite, fontSize: 20, fontWeight: FontWeight.w800),
    headlineLarge: headerStyle.copyWith(
        color: kWhite, fontSize: 24, fontWeight: FontWeight.w800),
    labelSmall: textStyle.copyWith(color: greyTitle, fontSize: 14),
    labelMedium: textStyle.copyWith(color: greyTitle, fontSize: 16),
    labelLarge: textStyle.copyWith(color: greyTitle, fontSize: 18),
    bodySmall: textStyle.copyWith(color: kWhite, fontSize: 14),
    bodyMedium: textStyle.copyWith(color: kWhite, fontSize: 16),
    bodyLarge: textStyle.copyWith(color: kWhite, fontSize: 18),
    titleSmall: textStyle.copyWith(
        color: greySubtitle, fontSize: 10, fontWeight: FontWeight.normal),
    titleMedium: textStyle.copyWith(
        color: greySubtitle, fontSize: 12, fontWeight: FontWeight.w500),
    titleLarge: textStyle.copyWith(
        color: greySubtitle, fontSize: 14, fontWeight: FontWeight.w500),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: greyDark,
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    hintStyle: TextStyle(
        color: kIndicatorColor, fontSize: 14, fontWeight: FontWeight.w500),
    filled: true,
    border: border,
    enabledBorder: border,
    focusedBorder: OutlineInputBorder(
      borderRadius: kBorderRadius,
      borderSide: BorderSide(color: greyTitle, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: kBorderRadius,
      borderSide: BorderSide(color: redErrorBorder, width: 1),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    modalBarrierColor: kWhite.withOpacity(0.15),
    elevation: 12,
  ),
  timePickerTheme: darkTimePickerTheme,
);

final textStyle = TextStyle(fontFamily: kFontFamily);
final headerStyle = TextStyle(fontFamily: kHeaderFontFamily);
final border = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: BorderSide(color: greyBorder, width: 1),
);
final borderDark = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: BorderSide(color: greySubtitle, width: 1),
);

final darkTimePickerTheme = TimePickerThemeData(
  backgroundColor: Colors.black, //
  dialBackgroundColor: Colors.grey[800],
  dialTextColor: Colors.white,
  entryModeIconColor: Colors.white,
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.black;
    }
    return Colors.white;
  }),
  hourMinuteColor: MaterialStateColor.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.grey[300]!;
    }
    return Colors.grey[700]!;
  }),
  helpTextStyle: TextStyle(
    color: Colors.grey[400],
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[900],
    hintStyle: TextStyle(
      color: Colors.grey[400],
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.grey[700]!,
      ),
    ),
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
);
