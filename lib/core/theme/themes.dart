import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorsPalette.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsPalette.white,
      titleTextStyle: GoogleFonts.nunitoSans(
        color: ColorsPalette.black,
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: ColorsPalette.appPrime),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: ColorsPalette.appPrime),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: ColorsPalette.appPrime),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: ColorsPalette.appPrime),
      ),
      hintStyle: AppTheme.text14Normal.copyWith(color: ColorsPalette.grey),
      labelStyle: AppTheme.text14Normal,
      floatingLabelStyle: AppTheme.text14Normal,
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsPalette.black,
      selectionColor: ColorsPalette.grey.withValues(alpha: 0.3),
      selectionHandleColor: ColorsPalette.black,
    ),

    textTheme: TextTheme(
      headlineMedium: text20Bold, // appbar title
      titleLarge: text18Bold, // large title
      titleMedium: text16Bold, //medium title
      titleSmall: text14Bold,
      bodyMedium: textStyle10,
      labelMedium: text12Normal,

      bodyLarge: text14Normal, // input text
    ),
  );

  static final TextStyle text20Bold = GoogleFonts.nunitoSans(
    color: ColorsPalette.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle text18Bold = GoogleFonts.nunitoSans(
    color: ColorsPalette.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle text16Bold = GoogleFonts.nunitoSans(
    color: ColorsPalette.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle text16medium = GoogleFonts.nunitoSans(
    color: ColorsPalette.black,
    fontSize: 16.sp,
  );

  static final TextStyle text14Bold = GoogleFonts.nunitoSans(
    color: ColorsPalette.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle text14Normal = GoogleFonts.nunitoSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: ColorsPalette.black,
  );

  static final TextStyle text12Normal = GoogleFonts.nunitoSans(
    fontSize: 12.sp,
    color: ColorsPalette.black,
  );

  static final TextStyle textStyle10 = GoogleFonts.nunitoSans(
    fontSize: 10.sp,
    color: ColorsPalette.black,
  );
}
