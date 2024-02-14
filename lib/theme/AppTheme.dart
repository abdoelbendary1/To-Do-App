import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color blackColor = const Color(0xff383838);
  static Color greenColor = const Color(0xff61E757);
  static Color redColor = const Color(0xffEC4B4B);
  static Color backgroundColor = const Color(0xffDFECDB);
  static Color blackColorDark = const Color(0xff060E1E);
  static Color greyColor = const Color(0xffC8C9CB);
  static Color backgrounColorDark = const Color(0xff060E1E);
  static Color bottomAppBarColorDark = const Color(0xff141922);
  static Color cardColorDark = const Color(0xff141922);
  static ThemeData lightMode = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        iconSize: 40,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(color: whiteColor, width: 4))),
    bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
        
      ),
    )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: const IconThemeData(size: 40),
      unselectedIconTheme: const IconThemeData(size: 30),
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
    ),
  );
  static ThemeData darkMode = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgrounColorDark,
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        iconSize: 40,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(color: bottomAppBarColorDark, width: 4))),
    bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: const IconThemeData(size: 40),
      unselectedIconTheme: const IconThemeData(size: 30),
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
    ),
  );
}
