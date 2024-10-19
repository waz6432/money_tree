// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:financial_ledger/app/app_prefs.dart';
import 'package:financial_ledger/app/di.dart';
import 'package:financial_ledger/presentation/resources/routes_manager.dart';
import 'package:financial_ledger/presentation/resources/theme_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  // 1. static 인스턴스 생성
  static final MyApp _instance = MyApp._internal();

  // 2. priavet 생성자 생성
  MyApp._internal();

  // 3. factory 생성자 생성
  factory MyApp() {
    return _instance;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    AppSizeConfig.init(context);
    _appPreferences.getLocale().then((locale) => context.setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
