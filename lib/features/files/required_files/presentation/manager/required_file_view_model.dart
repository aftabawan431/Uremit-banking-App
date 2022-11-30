import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/features/files/required_files/models/get_required_file_response_model.dart';
import 'package:uremit/features/files/required_files/models/get_required_files_request_model.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';
import '../../usecases/get_required_file_usecase.dart';

class RequiredFilesViewModel extends ChangeNotifier {
  RequiredFilesViewModel(this.requiredFileUsecase);

  // Usecases
  GetRequiredFileUsecase requiredFileUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<List<GetRequiredFilesResponseModelBody>> requiredFilesListNotifier = ValueNotifier([]);

  // Properties
  GetRequiredFileResponseModel? requiredFileResponseModel;
  GetRequiredFilesResponseModelBody? getRequiredFilesResponseModelBody;

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getRequiredFiles({bool recall = false}) async {
    if (!recall) {
      if (requiredFileResponseModel != null) {
        return;
      }
    }
    isLoadingNotifier.value = true;
    var requiredFilesEither = await requiredFileUsecase.call(GetRequiredFileRequestModel(id: _accountProvider.userDetails!.userDetails.id));
    if (requiredFilesEither.isLeft()) {
      handleError(requiredFilesEither);
      isLoadingNotifier.value = true;
    } else if (requiredFilesEither.isRight()) {
      requiredFilesEither.foldRight(null, (response, _) {
        requiredFileResponseModel = response;
        print('this is the response of required files request:$requiredFileResponseModel');
        requiredFilesListNotifier.value = requiredFileResponseModel == null ? [] : requiredFileResponseModel!.getProfileRequestBody;
      });
      isLoadingNotifier.value = false;
    }
  }

  clearFiles() {
    requiredFileResponseModel = null;
  }
  // Methods

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

// Page Moves
  void moveToDocRequiredPage() {
    appState.currentAction = PageAction(state: PageState.replace, page: PageConfigs.accountWrapperPageConfig);
  }
}
