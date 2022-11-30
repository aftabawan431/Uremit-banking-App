import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/files/previous_files/models/get_previous_file_response_model.dart';
import 'package:uremit/features/files/previous_files/models/get_previous_files_request_model.dart';
import 'package:uremit/features/files/previous_files/usecases/get_previous_file_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';

class PreviousFilesViewModel extends ChangeNotifier {
  PreviousFilesViewModel(this.previousFileUsecase);

  // Usecases
  GetPreviousFileUsecase previousFileUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<List<PreviousFileBody>> previousFilesListNotifier = ValueNotifier([]);

  // Properties
  GetPreviousFileResponseModel? previousFileResponseModel;
  PreviousFileBody? previousFileBody;

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getPreviousFiles([bool recall = false]) async {
    // if (!recall) {
    //   if (previousFileResponseModel != null) {
    //     return;
    //   }
    // }
    isLoadingNotifier.value = true;
    var previousFilesEither = await previousFileUsecase.call(GetPreviousFilesRequestModel(userId: _accountProvider.userDetails!.userDetails.id));
    if (previousFilesEither.isLeft()) {
      handleError(previousFilesEither);
      isLoadingNotifier.value = true;
    } else if (previousFilesEither.isRight()) {
      previousFilesEither.foldRight(null, (response, _) {

        previousFileResponseModel = response;
        previousFilesListNotifier.value = previousFileResponseModel == null ? [] : previousFileResponseModel!.previousFileBody;
      });
      isLoadingNotifier.value = false;
    }
  }

  clearFiles() {
    previousFileResponseModel = null;
  }
  // Methods

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

// Page Moves
  void moveToHeroImage() {
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.interactiveHeroPageScreenPageConfig);
  }
}
