import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_request_model.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_response_model.dart';
import 'package:uremit/features/menu/profile/usecases/get_profile_details_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this.getProfileDetailsUsecase);

  // Usecases
  GetProfileDetailsUsecase getProfileDetailsUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  // Properties
  PageController pageController = PageController();

  GetProfileDetailsResponseModel? profileDetails;

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getProfile({bool recall = false}) async {
    if (!recall) {
      if (profileDetails != null) {
        return;
      }
    }
    print('it is calling');
    isLoadingNotifier.value = true;

    var params = GetProfileDetailsRequestModel(id: _accountProvider.userDetails!.userDetails.id);

    var getProfileEither = await getProfileDetailsUsecase.call(params);

    if (getProfileEither.isLeft()) {
      handleError(getProfileEither);
      isLoadingNotifier.value = false;
    } else if (getProfileEither.isRight()) {
      getProfileEither.foldRight(null, (response, _) {
        profileDetails = response;
        print('this is the response of getProfile $profileDetails');
      });
      isLoadingNotifier.value = false;

      //
    }
  }

  clearData() {
    profileDetails = null;
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
