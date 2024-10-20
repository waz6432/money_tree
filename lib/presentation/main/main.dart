import 'package:financial_ledger/presentation/main/home/home_page.dart';
import 'package:financial_ledger/presentation/main/report_page.dart';
import 'package:financial_ledger/presentation/main/settings_page.dart';
import 'package:financial_ledger/presentation/main/transaction/new_transaction_page.dart';
import 'package:financial_ledger/presentation/resources/color_manager.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const <Widget>[
    HomePage(),
    ReportPage(),
    NewTransactionPage(),
    SettingsPage(),
  ];

  List<String> titles = const <String>[
    AppStrings.home,
    AppStrings.report,
    AppStrings.transaction,
    AppStrings.settings,
  ];

  var _title = AppStrings.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSize.s40,
        title: Text(
          _title,
          style: Theme.of(context).textTheme.displayMedium,
        ).tr(),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1),
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppStrings.home.tr()),
            BottomNavigationBarItem(icon: const Icon(Icons.area_chart_outlined), label: AppStrings.report.tr()),
            BottomNavigationBarItem(icon: const Icon(Icons.credit_card), label: AppStrings.transaction.tr()),
            BottomNavigationBarItem(icon: const Icon(Icons.settings), label: AppStrings.settings.tr()),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
