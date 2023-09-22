import 'package:flutter/material.dart';
import 'package:tif_assignment/constants.dart';

final ThemeData customTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Inter',
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(color: typographyTitle),
    titleTextStyle: TextStyle(
      color: typographyTitle,
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: const TextTheme(
    // event screen
    headline1: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: typographyTitle,
    ),
    subtitle1: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      color: typographySub,
    ),
    bodyText1: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      color: primaryBlue,
    ),

    // event details screen
    headlineLarge: TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.w400,
      color: typographyTitle,
    ),
    headline2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: typographyTitle,
    ),
    subtitle2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: typographySub,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: typographyTitle,
    ),
    headline3: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: typographyTitle,
    ),
  ),
);
