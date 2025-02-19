import 'package:flutter/material.dart';
import 'package:goldyu/core/theme/custome_themes/appBar_theme.dart';
import 'package:goldyu/core/theme/custome_themes/bottom_sheet_theme.dart';
import 'package:goldyu/core/theme/custome_themes/checkbox_theme.dart';
import 'package:goldyu/core/theme/custome_themes/chip_theme.dart';
import 'package:goldyu/core/theme/custome_themes/elevated_button_theme.dart';
import 'package:goldyu/core/theme/custome_themes/outlined_button_theme.dart';
import 'package:goldyu/core/theme/custome_themes/text_field_theme.dart';
import 'package:goldyu/core/theme/custome_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightTextFormFieldTheme,
  );
  static ThemeData dartTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkTextFormFieldTheme,
  );
}
