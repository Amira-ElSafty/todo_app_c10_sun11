import 'package:flutter/material.dart';

class MyTheme {
  // colors , light theme , dark theme
  static Color primaryColor = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffffffff);
  static Color backgroundColor = Color(0xffDFECDB);
  static Color greyColor = Color(0xffa1a3af);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff383838);
  static Color backgroundDarkColor = Color(0xff060E1E);
  static Color blackDarkColor = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          shape: StadiumBorder(side: BorderSide(color: whiteColor, width: 6))
          // RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(30),
          //   side: BorderSide(
          //     color: whiteColor,
          //     width: 6
          //   )
          // )
          ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              side: BorderSide(color: blackColor, width: 4))),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: blackColor),
        titleMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: blackColor),
      ));
}
