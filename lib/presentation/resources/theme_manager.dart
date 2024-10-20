import 'package:financial_ledger/presentation/resources/color_manager.dart';
import 'package:financial_ledger/presentation/resources/font_manager.dart';
import 'package:financial_ledger/presentation/resources/styles_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main color of the app
    primaryColor: ColorManager.primary,
    primaryColorDark: ColorManager.darkPrimary,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey1,

    splashColor: ColorManager.primaryOpacity70,

    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
    ),

    buttonTheme: ButtonThemeData(
      shape: const ContinuousRectangleBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16), // headline1
      displayMedium: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16), // headline2
      displaySmall: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16), // headline3
      headlineLarge: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16), // headline3
      headlineMedium: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16), // headline4
      titleLarge: getSemiBoldStyle(color: ColorManager.grey, fontSize: FontSize.s20), // subtitle2
      titleMedium: getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14), // subtitle1
      titleSmall: getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s14), // subtitle2
      bodyLarge: getRegularStyle(color: ColorManager.black), // bodyText1
      bodySmall: getRegularStyle(color: ColorManager.grey), // caption
      bodyMedium: getMediumStyle(color: ColorManager.lightGrey), // bodyText2
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
