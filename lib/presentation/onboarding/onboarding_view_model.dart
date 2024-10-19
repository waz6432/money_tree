import 'dart:async';

import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/presentation/base/base_view_model.dart';
import 'package:financial_ledger/presentation/resources/assets_manager.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel implements OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderObject();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex > _list.length) {
      _currentIndex = 0;
    }

    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex < 0) {
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  @override
  void onPageChange(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((slideViewObject) => slideViewObject);

  // private functions
  List<SliderObject> _getSliderObject() => [
        SliderObject(title: AppStrings.onboardingTitle1, subTitle: AppStrings.onboardingSubTitle1, image: ImageAssets.onboardingLogo1),
        SliderObject(title: AppStrings.onboardingTitle2, subTitle: AppStrings.onboardingSubTitle2, image: ImageAssets.onboardingLogo2),
        SliderObject(title: AppStrings.onboardingTitle3, subTitle: AppStrings.onboardingSubTitle3, image: ImageAssets.onboardingLogo3),
        SliderObject(title: AppStrings.onboardingTitle4, subTitle: AppStrings.onboardingSubTitle4, image: ImageAssets.onboardingLogo4),
        SliderObject(title: AppStrings.onboardingTitle5, subTitle: AppStrings.onboardingSubTitle5, image: ImageAssets.onboardingLogo5),
      ];

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      sliderObject: _list[_currentIndex],
      numOfSlides: _list.length,
      currentIndex: _currentIndex,
    ));
  }
}

abstract class OnboardingViewModelInputs {
  void goNext();
  int goPrevious();
  void onPageChange(int index);

  Sink get inputSliderViewObject;
}

abstract class OnboardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject({required this.sliderObject, required this.numOfSlides, required this.currentIndex});
}
