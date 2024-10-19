import 'dart:async';
import 'dart:io';

import 'package:financial_ledger/app/functions.dart';
import 'package:financial_ledger/domain/usecase/register_use_case.dart';
import 'package:financial_ledger/presentation/base/base_view_model.dart';
import 'package:financial_ledger/presentation/common/freezed_data_classes.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterViewModel extends BaseViewModel implements RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();
  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>.broadcast();

  var registerObject = RegisterObject(
    countryMobileCode: "",
    userName: "",
    email: "",
    password: "",
    mobileNumber: "",
    profilePicture: "",
  );

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      countryMobileCode: registerObject.countryMobileCode,
      userName: registerObject.userName,
      email: registerObject.email,
      password: registerObject.password,
      mobileNumber: registerObject.mobileNumber,
      profilePicture: "",
    )))
        .fold(
      (failure) {
        inputState.add(ErrorState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: failure.message,
        ));
      },
      (data) {
        inputState.add(ContentState());

        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _mobileNumberStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }

    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      registerObject = registerObject.copyWith(profilePicture: file.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  // outputs
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map(
        (userName) => _isUserNameValid(userName),
      );

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
        (isUserNameValid) => isUserNameValid ? null : AppStrings.invalidUsername.tr(),
      );

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map(
        (email) => isEmailValid(email),
      );

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map(
        (isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail.tr(),
      );

  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberStreamController.stream.map(
        (mobileNumber) => _isMobileNumberValid(mobileNumber),
      );

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map(
        (isMobileNumberValid) => isMobileNumberValid ? null : AppStrings.invalidMobileNumber.tr(),
      );

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map(
        (password) => _isPasswordValid(password),
      );

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
        (isPasswordValid) => isPasswordValid ? null : AppStrings.invalidPassword.tr(),
      );

  @override
  Stream<File?> get outputIsProfilePictureValid => _profilePictureStreamController.stream.map(
        (file) => file,
      );

  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController.stream.map(
        (_) => _validateAllInputs(),
      );

  // private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return registerObject.profilePicture.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  register();

  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File file);

  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<File?> get outputIsProfilePictureValid;

  Stream<bool> get outputIsAllInputsValid;
}
