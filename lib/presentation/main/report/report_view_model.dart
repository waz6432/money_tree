import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/domain/usecase/report_use_case.dart';
import 'package:financial_ledger/presentation/base/base_view_model.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class ReportViewModel extends BaseViewModel implements ReportViewModelInputs, ReportViewModelOutputs {
  final BehaviorSubject _dataStreamController = BehaviorSubject<ReportViewObject>();
  final BehaviorSubject _touchedIndexController = BehaviorSubject<int>.seeded(-1);

  final ReportUseCase _reportUseCase;
  ReportViewModel(this._reportUseCase);

  @override
  void start() {
    _getReport();
  }

  _getReport() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _reportUseCase.execute(null)).fold(
      (failure) {
        inputState.add(ErrorState(stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE, message: failure.message));
      },
      (reportObject) {
        inputState.add(ContentState());
        inputReportData.add(ReportViewObject(
          totalSpendings: reportObject.data.totalSpendings,
          categories: reportObject.data.categories,
          netWorth: reportObject.data.netWorth,
        ));
      },
    );
  }

  @override
  void dispose() {
    _dataStreamController.close();
    _touchedIndexController.close();
    super.dispose();
  }

  @override
  setTouchIndex(int? index) {
    inputTouchedIndex.add(index ?? -1);
  }

  @override
  Sink get inputTouchedIndex => _touchedIndexController.sink;

  @override
  Sink get inputReportData => _dataStreamController.sink;

  @override
  Stream<ReportViewObject> get outputReportData => _dataStreamController.stream.map((reportData) => reportData);

  @override
  Stream<int> get outputTouchedIndex => _touchedIndexController.stream.map((touchedIndex) => touchedIndex);
}

abstract class ReportViewModelInputs {
  setTouchIndex(int? index);

  Sink get inputTouchedIndex;

  Sink get inputReportData;
}

abstract class ReportViewModelOutputs {
  Stream<ReportViewObject> get outputReportData;

  Stream<int> get outputTouchedIndex;
}

class ReportViewObject {
  List<TotalSpending> totalSpendings;
  List<Categories> categories;
  NetWorth netWorth;

  ReportViewObject({
    required this.totalSpendings,
    required this.categories,
    required this.netWorth,
  });
}
