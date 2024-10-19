import 'dart:async';

import 'package:financial_ledger/domain/usecase/login_use_case.dart';
import 'package:financial_ledger/presentation/base/base_view_model.dart';
import 'package:financial_ledger/presentation/common/freezed_data_classes.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStremController = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<String>();

  var loginObject = LoginObject(userName: "", passowrd: "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void start() {
    // state renderer 호출
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStremController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputIsAllInputs => _isAllInputsValidStremController.sink;

  @override
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(LoginUseCaseInput(
      email: loginObject.userName,
      password: loginObject.passowrd,
    )))
        .fold(
      (failure) {
        // left -> failure
        inputState.add(ErrorState(stateRendererType: StateRendererType.POPUP_ERROR_STATE, message: failure.message));
      },
      (data) {
        // right -> success
        inputState.add(ContentState());

        isUserLoggedInSuccessfullyStreamController.add("TOKEN FROM API");
      },
    );
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(passowrd: password);
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map(
        (userName) => _isUserNameValid(userName),
      );

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map(
        (password) => _isPasswordValid(password),
      );

  @override
  Stream<bool> get outputIsAllValidInputsValid => _isAllInputsValidStremController.stream.map(
        (_) => _isAllInputsValid(),
      );

  // private functions
  _validate() => inputIsAllInputs.add(null);

  bool _isUserNameValid(String userName) => userName.isNotEmpty;

  bool _isPasswordValid(String password) => password.isNotEmpty;

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.passowrd) && _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  // three functions for actions
  setUserName(String userName);
  setPassword(String password);
  login();

  // two sinks for streams
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputs;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllValidInputsValid;
}
