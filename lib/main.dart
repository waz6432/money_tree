import 'package:easy_localization/easy_localization.dart';
import 'package:financial_ledger/app/app.dart';
import 'package:financial_ledger/app/di.dart';
import 'package:financial_ledger/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: const [ENGLISH_LOCALE, KOREAN_LOCALE],
    path: ASSETS_PATH_LOCALIZATIONS,
    child: Phoenix(child: MyApp()),
  ));
}
