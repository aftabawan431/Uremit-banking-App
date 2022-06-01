import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/features/authentication/login/models/login_response_model.dart';
import 'package:uremit/utils/router/models/page_config.dart';

import '../../services/error/failure.dart';
import '../../utils/constants/enums/page_state_enum.dart';
import '../../utils/router/app_state.dart';
import '../../utils/router/models/page_action.dart';
import '../models/device_info_model.dart';

class AccountProvider extends ChangeNotifier {
  ValueChanged<String>? errorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  LoginResponseModel? userDetails;

  void makeActionsBasedOnError(Failure l) {
    errorMessage?.call(l.message);
  }

  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) {
      makeActionsBasedOnError(l);
    }, (r) => null);
  }

  // Device Information
  String imei = '';
  String ip = '';
  String deviceName = '';
  String androidVersion = '';
  String appVersion = '1.0.0';

  void cacheDeviceInfo(DeviceInfoModel info) {
    imei = info.imei;
    ip = info.ip;
    deviceName = info.deviceName;
    androidVersion = info.androidVersion;
    appVersion = info.appVersion;
  }

  void moveToSplashPage() {
    var appState = GetIt.I.get<AppState>();
    appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.splashPageConfig);
  }
}
