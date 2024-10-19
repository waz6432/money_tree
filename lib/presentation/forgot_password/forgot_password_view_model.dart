import 'dart:async';

import 'package:financial_ledger/app/functions.dart';
import 'package:financial_ledger/domain/usecase/forgot_password_use_case.dart';
import 'package:financial_ledger/presentation/base/base_view_model.dart';
import 'package:financial_ledger/presentation/common/freezed_data_classes.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel implements ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();

  var emailObject = EmailObject(email: "");

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get isAllInputValid => _isAllInputValidStreamController.sink;

  @override
  forgotPassword() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase.execute(emailObject.email)).fold(
      (failure) {
        inputState.add(ErrorState(stateRendererType: StateRendererType.POPUP_ERROR_STATE, message: failure.message));
      },
      (supportMessage) {
        inputState.add(SuccessState(message: supportMessage));
      },
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    emailObject = emailObject.copyWith(email: email);
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map(
        (email) => isEmailValid(email),
      );

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController.stream.map(
        (isAllInputValid) => _isAllInputValid(),
      );

  // private functions
  _isAllInputValid() {
    return isEmailValid(emailObject.email);
  }

  _validate() {
    isAllInputValid.add(null);
  }
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);
  forgotPassword();

  Sink get inputEmail;
  Sink get isAllInputValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}
