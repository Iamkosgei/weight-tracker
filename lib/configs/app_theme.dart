import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  final AppColors appColors;

  AppTheme(this.appColors);
  ThemeData get appTheme {
    var baseTheme = ThemeData(
      primarySwatch: appColors.primarySwatch,
      primaryColor: appColors.primaryColor,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
    );
  }
}
