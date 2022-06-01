import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/widgets/custom_payment_navbar.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import '../../../../../app/widgets/customs/tabview/custom_tab_view.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/router/app_state.dart';

class PaymentWrapperViewModel extends ChangeNotifier {

  //custom navbar
  late int length;
  late double startingPos;
  int endingIndex = 0;
  late double pos;
  // Usecases

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  late Curve animationCurve;
  late Duration animationDuration;
  // Properties
  final GlobalKey<CustomTabViewState> bottomNavigationKey = GlobalKey();
  int currentIndex = 0;

  // Getters
  AppState appState = GetIt.I.get<AppState>();

  // Usecase Calls

  // Methods

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {

    isLoadingNotifier.value = false;

    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

// Page Moves
  setInitial(){
    endingIndex=0;

  }
buttonTap(int index){

  final newPosition = index / length;

    startingPos = pos;
   endingIndex = index;
    CustomPaymentTabBar.animationController.animateTo(newPosition, duration: animationDuration, curve: animationCurve);
    // _pageController.jumpToPage(index);
notifyListeners();
}
}
