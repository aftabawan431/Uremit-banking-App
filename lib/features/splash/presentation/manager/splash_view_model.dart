import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:uremit/app/models/device_info_model.dart';
import 'package:uremit/app/providers/account_provider.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/constants/enums/page_state_enum.dart';
import 'package:uremit/utils/router/models/page_action.dart';
import 'package:network_info_plus/network_info_plus.dart' as ipgetter;

import '../../../../app/globals.dart';
import '../../../../services/error/failure.dart';
import '../../../../utils/network/network_info.dart';
import '../../../../utils/router/app_state.dart';
import '../../../../utils/router/models/page_config.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel({required this.deviceInfo, required this.networkInfo});

  // Usecases
  final DeviceInfoPlugin deviceInfo;
  final NetworkInfo networkInfo;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  // Properties

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getDeviceInfo() async {
    isLoadingNotifier.value = true;
    if (Platform.isAndroid) {
      String? imei;
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      try {
        imei = await UniqueIdentifier.serial;
      } on PlatformException {
        onErrorMessage?.call(OnErrorMessageModel(message: 'Failed to get IMEI number'));
      }
      final ip= await ipgetter.NetworkInfo().getWifiIP();
      DeviceInfoModel info = DeviceInfoModel(
        imei: imei ?? '',
        ip: ip??'',
        deviceName: androidDeviceInfo.device ?? '',
        androidVersion: androidDeviceInfo.androidId ?? '',
        appVersion: '1.0.0',
      );
      _accountProvider.cacheDeviceInfo(info);
    } else if (Platform.isIOS) {
      // TODO: DEVICE INFO FOR IOS SUPPORT
      // IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    }
    isLoadingNotifier.value = false;
  }

  // Methods

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

  // Page Moves
  void moveToAuthWrapperPage() {
    appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.authWrapperPageConfig);
  }
}
