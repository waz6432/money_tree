import 'package:financial_ledger/data/mapper/mapper.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// loading state (POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  String message;

  LoadingState({
    required this.stateRendererType,
    String? message,
  }) : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (POPUP, FULL LOADING)

class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  String message;

  ErrorState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_SCREEN_STATE;
}

// empty state
class EmptyState extends FlowState {
  String message;

  EmptyState({required this.message});

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() => StateRendererType.EMPTY_SCREEN_STATE;
}

class SuccessState extends FlowState {
  String message;

  SuccessState({required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.POPUP_SUCCESS;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget({
    required BuildContext context,
    required Widget contentScreenWidget,
    required Function retryActionFunction,
    required Function resetStateFunction,
  }) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            _dismissDialog(context);

            // 팝업창 띄우기
            _showPopUp(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              resetStateFunction: resetStateFunction,
            );

            // 화면
            return contentScreenWidget;
          } else {
            // StateRendererType.FULL_SCREEN_LOADING_STATE
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              resetStateFunction: resetStateFunction,
            );
          }
        }
      case ErrorState:
        {
          _dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            // 팝업창 띄우기
            _showPopUp(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              resetStateFunction: resetStateFunction,
            );

            // 화면
            return contentScreenWidget;
          } else {
            // StateRendererType.FULL_SCREEN_ERROR_STATE
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              resetStateFunction: resetStateFunction,
            );
          }
        }
      case ContentState:
        return contentScreenWidget;
      case SuccessState:
        {
          _dismissDialog(context);
          _showPopUp(
            context: context,
            title: AppStrings.success.tr(),
            stateRendererType: StateRendererType.POPUP_SUCCESS,
            message: getMessage(),
            resetStateFunction: resetStateFunction,
          );

          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
            resetStateFunction: resetStateFunction,
          );
        }
      default:
        return contentScreenWidget;
    }
  }

  _dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  _showPopUp({
    required BuildContext context,
    required StateRendererType stateRendererType,
    required String message,
    required Function resetStateFunction,
    String title = EMPTY,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isThereCurrentDialogShowing(context)) {
        showDialog(
          context: context,
          builder: (context) => StateRenderer(
            stateRendererType: stateRendererType,
            resetStateFunction: resetStateFunction,
            retryActionFunction: () {},
            message: message,
            title: title,
          ),
        );
      }
    });
  }
}
