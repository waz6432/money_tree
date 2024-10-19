import 'package:financial_ledger/app/app_prefs.dart';
import 'package:financial_ledger/app/di.dart';
import 'package:financial_ledger/data/data_source/local_data_source.dart';
import 'package:financial_ledger/presentation/resources/assets_manager.dart';
import 'package:financial_ledger/presentation/resources/routes_manager.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p8),
          children: [
            ListTile(
              title: Text(
                AppStrings.changeLanguage,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              leading: SvgPicture.asset(ImageAssets.chageLangIc),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
              onTap: _changeLanguage,
            ),
            ListTile(
              title: Text(
                AppStrings.contactUs,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              leading: SvgPicture.asset(ImageAssets.contactUsIc),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
              onTap: _contactUs,
            ),
            ListTile(
              title: Text(
                AppStrings.inviteYourFriends,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
              onTap: _inviteFriends,
            ),
            ListTile(
              title: Text(
                AppStrings.logout,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              leading: SvgPicture.asset(ImageAssets.logoutIc),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage() {
    _appPreferences.setLanguageChanged();
    Phoenix.rebirth(context); // 재시작 후 언어 교체
  }

  void _contactUs() {}

  void _inviteFriends() {}

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
