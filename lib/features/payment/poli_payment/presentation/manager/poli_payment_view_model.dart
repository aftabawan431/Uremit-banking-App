import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../../services/error/failure.dart';
import '../../../../../utils/router/app_state.dart';

class PoliPaymentViewModel extends ChangeNotifier {
  // Usecases

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  // Properties

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
}
