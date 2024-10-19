// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, KOREAN }

const String KOREAN = "ko";
const String ENGLISH = "en";
const String ASSETS_PATH_LOCALIZATIONS = "assets/translations";
const Locale KOREAN_LOCALE = Locale("ko", "KR");
const Locale ENGLISH_LOCALE = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.KOREAN:
        return KOREAN;
    }
  }
}
