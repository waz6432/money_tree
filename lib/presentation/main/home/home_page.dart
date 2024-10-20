import 'package:financial_ledger/app/di.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:financial_ledger/presentation/main/home/home_view_model.dart';
import 'package:financial_ledger/presentation/resources/color_manager.dart';
import 'package:financial_ledger/presentation/resources/font_manager.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                  context: context,
                  contentScreenWidget: _getContentWidget(),
                  retryActionFunction: _viewModel.start,
                  resetStateFunction: _viewModel.resetState,
                ) ??
                Container();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder(
        stream: _viewModel.outputHomeData,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getPersonalFinance(snapshot.data?.personalFinance),
                _getSection(AppStrings.accounts),
                _getAccounts(snapshot.data?.accounts),
                _getSection(AppStrings.recentTransaction),
                _getRecentTransactions(snapshot.data?.recentTransactions),
              ],
            ),
          );
        });
  }

  Widget _getPersonalFinance(PersonalFinance? personalFinance) {
    if (personalFinance != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _financeCardWidget(
                  title: AppStrings.netWorth,
                  value: personalFinance.netWorth,
                ),
              ),
              const SizedBox(width: AppSize.s10),
              Expanded(
                child: _financeCardWidget(
                  title: AppStrings.totalDebt,
                  value: personalFinance.totalDebt,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          _financeCardWidget(
            title: AppStrings.totalAssets,
            value: personalFinance.totalAssets,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _financeCardWidget({required String title, required int value}) {
    return Card(
      elevation: AppSize.s1_5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        side: BorderSide(color: ColorManager.white, width: AppSize.s1_5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p18,
          top: AppPadding.p24,
          bottom: AppPadding.p24,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall,
              ).tr(),
              const SizedBox(height: AppPadding.p8),
              Text(
                NumberFormat.simpleCurrency(locale: AppStrings.currency.tr()).format(value),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: ColorManager.darkGrey,
                      fontSize: FontSize.s24,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p16,
        left: AppPadding.p10,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ).tr(),
    );
  }

  Widget _getAccounts(List<Account>? accounts) {
    if (accounts != null) {
      return Padding(
        padding: const EdgeInsets.only(top: AppPadding.p5),
        child: SizedBox(
          height: AppSize.s100,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              return ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  accounts[index].type,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: FontSize.s14,
                      ),
                ),
                subtitle: Text(
                  accounts[index].accountNumber,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: ColorManager.darkGrey,
                        fontSize: FontSize.s14,
                      ),
                ),
                trailing: Text(
                  NumberFormat.simpleCurrency(locale: AppStrings.currency.tr()).format(accounts[index].balance),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: FontSize.s14,
                      ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getRecentTransactions(List<RecentTransaction>? recentTransactions) {
    if (recentTransactions != null) {
      return Padding(
        padding: const EdgeInsets.only(top: AppPadding.p18),
        child: SizedBox(
          height: AppSize.s100,
          child: ListView.builder(
            itemCount: recentTransactions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p10,
                  bottom: AppPadding.p20,
                ),
                child: Text(
                  recentTransactions[index].description,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: FontSize.s14,
                      ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
