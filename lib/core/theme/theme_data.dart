import 'package:chicly_store/core/constant/color_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: ColorApp.primayLight,
  primaryColor: ColorApp.primayLight,
  colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.cusBlueDark
  ,brightness: Brightness.dark
  ),
 
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: ColorApp.grey,
  primaryColor: ColorApp.primayLight,
  colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.cusBlue,brightness: Brightness.light),
  
);
