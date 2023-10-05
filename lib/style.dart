import 'package:flutter/material.dart';

/*
 * themes defined for indt product, thus defining each color, letter in the entire system
 * @author  SGV - 20231004
 * @version 1.0 - 20231004 - initial release
 */
class IndtProductStyle {
  final ThemeData theme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: CustomColors.backgroundColorDark,
    primaryColorDark: CustomColors.backgroundColorDark,
    colorScheme: ColorScheme.fromSwatch(errorColor: CustomColors.cancelActionButtonColor, backgroundColor:  CustomColors.frontColor).copyWith(
      primary: Colors.black,
      secondary: CustomColors.disabledColor,
    ),
    cardColor:  CustomColors.frontColor,
    canvasColor:  CustomColors.frontColor,
    dividerColor: CustomColors.disabledColor,
    disabledColor: CustomColors.disabledColor,
    iconTheme: const IconThemeData(color: Colors.black),
  );
}

class CustomColors {
  static Color backgroundColorDark = Colors.black;
  static Color frontColor = Colors.white;
  static Color secundaryColor = const Color(0xfffbbb21);
  static Color activeButtonColor = Colors.green;
  static Color cancelActionButtonColor = Colors.red;
  static Color disabledColor =  Colors.blueGrey;
  
}
