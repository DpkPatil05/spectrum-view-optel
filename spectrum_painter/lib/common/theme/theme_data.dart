import 'package:flutter/material.dart';

import '../common_constants.dart';

class CustomThemeData {
  CustomThemeData._();

  static ThemeData get defaultTheme => ThemeData(
    fontFamily: StringConstants.fontPrompt,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      brightness: Brightness.dark,
      primary: ColorConstants.primary,
      secondary: ColorConstants.accent,
      tertiary: ColorConstants.tertiary,
      surface: ColorConstants.secondary,
      error: ColorConstants.error,
    ),
    scaffoldBackgroundColor: ColorConstants.primary,
    textTheme: TextTheme(
      bodyLarge: defaultTextStyle,
      titleLarge: titleTextStyle,
      headlineMedium: headerTextStyle,
    ),
    dividerTheme: DividerThemeData(
      color: ColorConstants.lightGray,
      thickness: SpaceConstants.space2,
      indent: SpaceConstants.space10,
      endIndent: SpaceConstants.space10,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: defaultOutlineInputBorder(),
      focusedBorder: defaultOutlineInputBorder(color: ColorConstants.accent),
      errorBorder: defaultOutlineInputBorder(color: ColorConstants.error),
      focusedErrorBorder: defaultOutlineInputBorder(
        color: ColorConstants.error,
      ),
      border: defaultOutlineInputBorder(),
    ),
  );

  static TextStyle get defaultTextStyle => TextStyle(
    color: ColorConstants.primaryTextColor,
    fontSize: SpaceConstants.defaultFontSize,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get titleTextStyle => TextStyle(
    color: ColorConstants.primaryTextColor,
    fontSize: SpaceConstants.defaultTitleFontSize,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get headerTextStyle => TextStyle(
    color: ColorConstants.primaryTextColor,
    fontSize: SpaceConstants.headerFontSize,
    fontWeight: FontWeight.w700,
  );

  static OutlineInputBorder defaultOutlineInputBorder({
    Color color = ColorConstants.tertiary,
  }) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: SpaceConstants.space2),
    borderRadius: BorderRadius.circular(SpaceConstants.defaultCornerRadius),
  );

  static RoundedRectangleBorder defaultRoundedRectangleBorder({
    Color color = ColorConstants.tertiary,
  }) => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(SpaceConstants.defaultCornerRadius),
    side: BorderSide(color: color, width: SpaceConstants.buttonBorderThickness),
  );

  static Text headerText({
    bool darkText = false,
    TextAlign textAlign = TextAlign.left,
    required String text,
  }) => Text(
    text,
    softWrap: true,
    textAlign: textAlign,
    style: headerTextStyle.copyWith(
      color: darkText ? ColorConstants.black : headerTextStyle.color,
    ),
  );

  static Text titleText({
    bool lightText = false,
    TextAlign textAlign = TextAlign.left,
    required String text,
  }) => Text(
    text,
    softWrap: true,
    textAlign: textAlign,
    style: titleTextStyle.copyWith(
      color: lightText ? ColorConstants.white : titleTextStyle.color,
    ),
  );

  static Text bodyText({
    bool lightText = false,
    TextAlign textAlign = TextAlign.left,
    required String text,
  }) => Text(
    text,
    softWrap: true,
    textAlign: textAlign,
    style: defaultTextStyle.copyWith(
      color: lightText ? ColorConstants.white : defaultTextStyle.color,
    ),
  );

  static Divider get horizontalDivider => const Divider(
    thickness: SpaceConstants.space2,
    color: ColorConstants.lightGray,
    indent: SpaceConstants.space10,
    endIndent: SpaceConstants.space10,
  );

  static VerticalDivider get verticalDivider => const VerticalDivider(
    thickness: SpaceConstants.space2,
    color: ColorConstants.lightGray,
    indent: SpaceConstants.space10,
    endIndent: SpaceConstants.space10,
  );
}
