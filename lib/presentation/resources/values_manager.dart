import 'package:flutter/material.dart';

class AppSizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData.size.height;
    screenWidth = mediaQueryData.size.width;
  }

  static double get getProportionateHeight {
    return screenHeight * 0.25;
  }

  static double get getProportionateWidth {
    return screenWidth * 0.9;
  }
}

class AppSize {
  static const double s0 = 0.0;
  static const double s1_5 = 1.5;
  static const double s2 = 2.0;
  static const double s1 = 1.0;
  static const double s4 = 4.0;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s28 = 28.0;
  static const double s30 = 30.0;
  static const double s40 = 40.0;
  static const double s45 = 45.0;
  static const double s50 = 50.0;
  static const double s60 = 60.0;
  static const double s100 = 100.0;
  static const double s150 = 150.0;
  static const double s180 = 180.0;
  static const double s200 = 200.0;
  static const double s250 = 250.0;
  static const double s300 = 300.0;
  static const double s400 = 400.0;
}

class AppMargin {
  static const double m8 = 8.0;
  static const double m10 = 10.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
}

class AppPadding {
  static const double p2 = 2.0;
  static const double p5 = 5.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p30 = 30.0;
  static const double p28 = 28.0;
  static const double p40 = 40.0;
  static const double p60 = 60.0;
  static const double p80 = 80.0;
  static const double p100 = 100.0;
}

class DurationConstant {
  static const int i2000 = 2000;
  static const int i300 = 300;
}
