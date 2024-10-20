import 'dart:async';

import 'package:financial_ledger/domain/usecase/new_transaction_use_case.dart';
import 'package:financial_ledger/presentation/base/base_view_model.dart';
import 'package:financial_ledger/presentation/common/freezed_data_classes.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class NewTransactionViewModel extends BaseViewModel implements TransactionViewModelInputs, TransactionViewModelOutputs {
  final StreamController _amountStreamController = StreamController<int>.broadcast();
  final StreamController _noteStreamController = StreamController<String>.broadcast();
  final StreamController _categoryStreamController = StreamController<String>.broadcast();
  final StreamController _dateStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStremController = StreamController<void>.broadcast();
  final StreamController isAddNewTransactionSuccessfullyStreamController = StreamController<bool>.broadcast();

  final NewTransactionUseCase _newTransactionUseCase;

  NewTransactionViewModel(this._newTransactionUseCase);

  var newTransactionObject = NewTransactionObject(
    amount: 0,
    note: "",
    category: "",
    date: "",
  );

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  newTransaction() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _newTransactionUseCase.execute(NewTransactionUseCaseInput(
      amount: newTransactionObject.amount,
      note: newTransactionObject.note,
      category: newTransactionObject.category,
      date: newTransactionObject.date,
    )))
        .fold(
      (faliure) {
        inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,
          message: faliure.message,
        ));
      },
      (newTransactionData) {
        inputState.add(ContentState());

        isAddNewTransactionSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  void dispose() {
    _amountStreamController.close();
    _noteStreamController.close();
    _categoryStreamController.close();
    _dateStreamController.close();
    _isAllInputsValidStremController.close();
    isAddNewTransactionSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputAmount => _amountStreamController.sink;

  @override
  Sink get inputNote => _noteStreamController.sink;

  @override
  Sink get inputCategory => _categoryStreamController.sink;

  @override
  Sink get inputDate => _dateStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStremController.sink;

  @override
  setAmount(int amount) {
    inputAmount.add(amount);
    if (_isAmountValid(amount)) {
      newTransactionObject = newTransactionObject.copyWith(amount: amount);
    } else {
      newTransactionObject = newTransactionObject.copyWith(amount: 0);
    }

    _validate();
  }

  @override
  setCategory(String category) {
    inputCategory.add(category);
    if (_isCategoryValid(category)) {
      newTransactionObject = newTransactionObject.copyWith(category: category);
    } else {
      newTransactionObject = newTransactionObject.copyWith(category: "");
    }

    _validate();
  }

  @override
  setDate(String date) {
    inputDate.add(date);
    newTransactionObject = newTransactionObject.copyWith(date: date);
    if (_isDateValid(date)) {
      newTransactionObject = newTransactionObject.copyWith(date: date);
    } else {
      newTransactionObject = newTransactionObject.copyWith(date: "");
    }

    _validate();
  }

  @override
  setNote(String note) {
    inputNote.add(note);
    newTransactionObject = newTransactionObject.copyWith(note: note);

    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsAmountValid => _amountStreamController.stream.map(
        (amount) => _isAmountValid(amount),
      );

  @override
  Stream<String?> get outputErrorAmount => outputIsAmountValid.map(
        (isAmountValid) => isAmountValid ? null : AppStrings.invalidAmount.tr(),
      );

  @override
  Stream<String> get outputNote => _noteStreamController.stream.map(
        (note) => note,
      );

  @override
  Stream<DateTime> get outputDate => _dateStreamController.stream.map(
        (date) => date,
      );

  @override
  Stream<String> get outputCategory => _categoryStreamController.stream.map(
        (category) => category,
      );

  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStremController.stream.map(
        (_) => _validAllInputs(),
      );

  // private functions
  bool _isAmountValid(int amount) {
    return amount != 0;
  }

  bool _isCategoryValid(String category) {
    return category.isNotEmpty;
  }

  bool _isDateValid(String date) {
    return date.isNotEmpty;
  }

  bool _validAllInputs() {
    return newTransactionObject.amount > 0 && newTransactionObject.category.isNotEmpty && newTransactionObject.date.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class TransactionViewModelInputs {
  newTransaction();

  setAmount(int amount);
  setNote(String note);
  setCategory(String category);
  setDate(String date);

  Sink get inputAmount;
  Sink get inputNote;
  Sink get inputCategory;
  Sink get inputDate;
  Sink get inputAllInputsValid;
}

abstract class TransactionViewModelOutputs {
  Stream<bool> get outputIsAmountValid;
  Stream<String?> get outputErrorAmount;

  Stream<String> get outputNote;

  Stream<DateTime> get outputDate;

  Stream<String> get outputCategory;

  Stream<bool> get outputIsAllInputsValid;
}
