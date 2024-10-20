import 'dart:async';

import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/domain/usecase/home_use_case.dart';
import 'package:financial_ledger/presentation/base/base_view_model.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel implements HomeViewModelInputs, HomeViewModelOutputs {
  // final StreamController _personalFinanceStreamController = BehaviorSubject<PersonalFinance>();
  // final StreamController _accountsStreamController = BehaviorSubject<List<Account>>();
  // final StreamController _recentTransactionsStreamController = BehaviorSubject<List<RecentTransaction>>();
  final BehaviorSubject _datastreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  // inputs
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _homeUseCase.execute(null)).fold(
      (failure) {
        inputState.add(ErrorState(stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE, message: failure.message));
      },
      (homeObject) {
        inputState.add(ContentState());
        inputHomeData.add(HomeViewObject(
          personalFinance: homeObject.data.personalFinance,
          accounts: homeObject.data.accounts,
          recentTransactions: homeObject.data.recentTransaction,
        ));
      },
    );
  }

  @override
  void dispose() {
    _datastreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _datastreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData => _datastreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  PersonalFinance personalFinance;
  List<Account> accounts;
  List<RecentTransaction> recentTransactions;

  HomeViewObject({
    required this.personalFinance,
    required this.accounts,
    required this.recentTransactions,
  });
}
