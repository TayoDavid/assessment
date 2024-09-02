import 'package:flutter/material.dart';

/// The default border radius used throughout the app.
const kShapeBorder = RoundedRectangleBorder(
  borderRadius: kBorderRadius,
);
const kRadius = Radius.circular(16);
const kRadius2 = Radius.circular(24);
const kBorderRadius = BorderRadius.all(kRadius);
const kSharpBorderRadius = BorderRadius.all(Radius.circular(40));
const kBorderRadiusTop = BorderRadius.only(topLeft: kRadius, topRight: kRadius);
const kBorderRadiusBottom =
    BorderRadius.only(bottomLeft: kRadius, bottomRight: kRadius);

/// The default animation durations.
const kShortAnimationDuration = Duration(milliseconds: 300);
const kLongAnimationDuration = Duration(milliseconds: 600);

/// The default fonts.
const kFontFamily = 'Poppins';
const kHeaderFontFamily = 'Nunito';

const Color kBlack = Colors.black;
const Color kWhite = Colors.white;
const Color kIndicatorColor = Color(0xFF858585);
const Color bluePrimary = Color(0xFF36A0FC);
const Color blueSecondary = Color(0xFFE6F3FF);
const Color blue100 = Color(0xFFCDE7FE);
const Color blue300 = Color(0xFF68B7FD);
const Color skyBlue = Color(0xFF013665);
const Color orangePrimary = Color(0xFFFFC800);
const Color orangeSecondary = Color(0xFFFFF4CC);
const Color orangeTertiary = Color(0xFFFFF9E5);
const Color orange200 = Color(0xFFFFE999);
const Color orange700 = Color(0xFF997800);
const Color pinkPrimary = Color(0xFFDB3FF3);
const Color pinkSecondary = Color(0xFFFAE7FD);
const Color pink100 = Color(0xFFF6CFFC);
const Color redErrorBorder = Color(0xFFF4A4A4);
const Color redErrorBg = Color(0xFFFCE8E8);
const Color redText = Color(0xFFEB5757);
const Color green = Color(0xFF7BC043);
const Color mildGreenBorder = Color(0xFF8DAA22);
const Color mildGreenBg = Color(0xFFF7FBEA);
const Color mildGreenCard = Color(0xFFDFEEAA);
const Color mildGreen100 = Color(0xFFEFF7D4);
const Color mildGreen500 = Color(0xFFCEE57D);
const Color green700 = Color(0xFF698019);
const Color greyLightBg = Color(0xFFF9F9F9);
const Color greyInput = Color(0xFFF3F3F3);
const Color greyBorder = Color(0xFFE6E6E6);
const Color greyTitle = Color(0xFF666666);
const Color grey300 = Color(0xFFB3B3B3);
const Color greySubtitle = Color(0xFF999999);
const Color greyDark = Color(0xFF333333);
const Color optionalGrey = Color(0xFFCCCCCC);

List<BoxShadow> get shadow {
  return [
    BoxShadow(
      color: Color.fromARGB(25, 169, 169, 169),
      blurRadius: 15,
      offset: Offset(10, 10),
    ),
    BoxShadow(
      color: Color.fromARGB(25, 169, 169, 169),
      blurRadius: 15,
      offset: Offset(-10, 0),
    )
  ];
}

List<BoxShadow> get lightShadow {
  return [
    BoxShadow(
      color: Color.fromARGB(25, 169, 169, 169),
      blurRadius: 15,
      offset: Offset(1, 1),
    ),
    BoxShadow(
      color: Color.fromARGB(25, 169, 169, 169),
      blurRadius: 15,
      offset: Offset(-1, 0),
    )
  ];
}
