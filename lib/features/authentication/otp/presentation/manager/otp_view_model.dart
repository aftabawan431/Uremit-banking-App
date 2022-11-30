import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/manager/auth_wrapper_view_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/usecases/validate_otp_usecase.dart';
import 'package:uremit/features/authentication/login/presentation/manager/login_view_model.dart';
import 'package:uremit/features/authentication/otp/models/generate_otp_request_model.dart';
import 'package:uremit/features/authentication/otp/usecases/generate_otp_usecase.dart';
import 'package:uremit/features/authentication/registration/presentation/manager/registration_view_model.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/router/models/page_action.dart';
import 'package:uremit/utils/router/models/page_config.dart';

import '../../../../../app/globals.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/globals/app_globals.dart';
import '../../../../../utils/router/app_state.dart';

class OtpViewModel extends ChangeNotifier {
  OtpViewModel({required this.validateOtpUsecase, required this.generateOtpUsecase});

  // Usecases
  ValidateOtpUsecase validateOtpUsecase;
  GenerateOtpUsecase generateOtpUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);


  // Properties
  final TextEditingController otpController = TextEditingController();
  // final StreamController<ErrorAnimationType> errorStream = StreamController<ErrorAnimationType>.broadcast();

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  RegistrationViewModel get _registrationViewModel => sl();
  LoginViewModel get _loginViewModel => sl();
  AuthWrapperViewModel get _authWrapperViewModel => sl();

  // Usecase Calls
  Future<void> validateOtp(String otp) async {
    isLoadingNotifier.value = true;

    var pageIndex = _authWrapperViewModel.currentIndex;
    var email = _getEmail();

    if (email.isEmpty) {
      return;
    }

    var params = ValidateOtpRequestModel(otpCode: otp, otpType: 1, email: email);

    var validateOtpEither = await validateOtpUsecase.call(params);

    if (validateOtpEither.isLeft()) {
      handleError(validateOtpEither);
      isLoadingNotifier.value = false;
    } else if (validateOtpEither.isRight()) {
      validateOtpEither.foldRight(null, (response, _) {
        if (response.otpBody.result) {
          _registrationViewModel.clearFields();
          _loginViewModel.clearFields();
          onErrorMessage?.call(OnErrorMessageModel(message: 'Account Verified', backgroundColor: Colors.green));
          otpController.clear();
          if (pageIndex == 0) {
            otpController.clear();
            sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
              sessionSeconds--;
              if (sessionSeconds == 0) {
                sessionTimer!.cancel();
                await _loginViewModel.logOut();
                onErrorMessage?.call(OnErrorMessageModel(message: 'session expired login again', backgroundColor: Colors.grey));
                appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.authWrapperPageConfig);
                // move user to login
              }
            });
            moveToHomePage();
          } else if (pageIndex == 1) {
            moveToAuthWrapperPage();
          }
        } else {
          onErrorMessage?.call(OnErrorMessageModel(message: 'Invalid OTP'));
          // errorStream.sink.add(ErrorAnimationType.shake);
        }
      });
      isLoadingNotifier.value = false;
    }
  }
  bool otpTimer =true;
  startTimer()async{
    otpTimer =false;
    notifyListeners();
  }
  otpTimerChange(bool value){
    otpTimer=value;
    notifyListeners();
  }
  Future<void> generateOtp() async {
    isLoadingNotifier.value = true;
    otpTimerChange(true);
    var email = _getEmail();

    if (email.isEmpty) {
      return;
    }

    var params = GenerateOtpRequestModel(email, 1);

    var generateOtpEither = await generateOtpUsecase.call(params);

    if (generateOtpEither.isLeft()) {
      handleError(generateOtpEither);
      isLoadingNotifier.value = false;
    } else if (generateOtpEither.isRight()) {
      onErrorMessage?.call(OnErrorMessageModel(message: 'OTP sent!', backgroundColor: Colors.grey));
      isLoadingNotifier.value = false;
    }
  }

  // Methods
  // void onCompleted(String value) {
  //   isLoadingNotifier.value = false;
  //   Logger().w(value);
  //   validateOtp(value);
  // }

  void onChanged(String value) {
    if (value.length == 4) {
      Logger().v(value);
      validateOtp(value);
    }
  }

  bool beforeTextPaste(String? value) {
    return true;
  }

  String _getEmail() {
    if (_authWrapperViewModel.currentIndex == 1) {
      return _registrationViewModel.emailController.text;
    } else if (_authWrapperViewModel.currentIndex == 0) {
      return _loginViewModel.emailController.text;
    } else {
      return '';
    }
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

  // Page Moves
  void moveToAuthWrapperPage() {
    AppState appState = sl();
    appState.moveToBackScreen();
    _authWrapperViewModel.bottomNavigationKey.currentState!.setPage(0);

    appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.authWrapperPageConfig);
  }

  void moveToHomePage() {
    appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.homePageConfig);
  }
}
