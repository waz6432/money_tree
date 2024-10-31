import 'package:financial_ledger/app/di.dart';
import 'package:financial_ledger/presentation/forgot_password/forgot_password.dart';
import 'package:financial_ledger/presentation/login/login.dart';
import 'package:financial_ledger/presentation/main/main.dart';
import 'package:financial_ledger/presentation/onboarding/onboarding.dart';
import 'package:financial_ledger/presentation/register/register.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:financial_ledger/presentation/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String registerRoute = "/register";
  static const String mainRoute = "/main";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnboardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (context) => const LoginView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (context) => const RegisterView());
      case Routes.mainRoute:
        initHomeModule();
        initNewTransactionModule();
        initReportModule();
        return MaterialPageRoute(builder: (context) => const MainView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound).tr(),
        ),
        body: Center(
          child: const Text(AppStrings.noRouteFound).tr(),
        ),
      ),
    );
  }
}
