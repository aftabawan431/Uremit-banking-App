import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/app/my_app.dart';
import 'package:uremit/app/providers/account_provider.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/manager/auth_wrapper_view_model.dart';
import 'package:uremit/features/authentication/login/models/login_request_model.dart';
import 'package:uremit/features/authentication/login/models/logout_request_model.dart';
import 'package:uremit/features/authentication/login/models/logout_response_model.dart';
import 'package:uremit/features/authentication/login/usecases/login_usecase.dart';
import 'package:uremit/features/authentication/login/usecases/logout_usecase.dart';
import 'package:uremit/features/authentication/otp/presentation/manager/otp_view_model.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/features/files/previous_files/presentation/manager/previous_files_view_model.dart';
import 'package:uremit/features/files/required_files/presentation/manager/required_file_view_model.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/menu/profile/presentation/manager/profile_view_model.dart';
import 'package:uremit/features/menu/update_profile/presentation/manager/update_profile_view_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/utils/constants/enums/page_state_enum.dart';
import 'package:uremit/utils/router/models/page_action.dart';
import 'package:uremit/utils/router/models/page_config.dart';

import '../../../../../app/globals.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../services/models/on_error_message_model.dart';
import '../../../../../utils/globals/app_globals.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../../../files/previous_files/presentation/manager/previous_files_view_model.dart';
import '../../../../payment/payment_details/presentation/manager/payment_details_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this.loginUsecase, this.logoutUsecase);

  // Usecases
  LoginUsecase loginUsecase;
  LogoutUsecase logoutUsecase;
  LogoutResponseModel? logoutResponseModel;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isLogOutLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> obsecureTextNotifier = ValueNotifier(true);

  bool isEmailError = false;
  bool isPasswordError = false;
  bool isButtonPressed = false;

  // Properties
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String emailLabelText = 'Email';
  final String emailHintText = 'Enter Email Address';
  final TextEditingController emailController = TextEditingController(text: 'test@gmail.com');
  final FocusNode emailFocusNode = FocusNode();

  final String passwordLabelText = 'Password';
  final String passwordHintText = 'Enter Password';
  final TextEditingController passwordController = TextEditingController(text: 'Login@786');
  final FocusNode passwordFocusNode = FocusNode();

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();
  AuthWrapperViewModel get _authWrapperViewModel => sl();
  OtpViewModel get _otpViewModel => sl();
  PreviousFilesViewModel previousFilesViewModel = sl();
  RequiredFilesViewModel requiredFilesViewModel = sl();
  UpdateProfileViewModel updateProfileViewModel = sl();
  PaymentDetailsViewModel paymentDetailsViewModel = sl();
  HomeViewModel homeViewModel = sl();
  ProfileViewModel profileViewModel = sl();

  // Usecase Calls
  Future<void> login() async {
    isLoadingNotifier.value = true;
    _authWrapperViewModel.currentIndex = 0;
    var params = LoginRequestModel(
      clientId: 1,
      email: emailController.text,
      password: passwordController.text,
      imei: _accountProvider.imei,
      ip: _accountProvider.ip,
      deviceName: _accountProvider.deviceName,
      androidVersion: _accountProvider.androidVersion,
      appVersion: _accountProvider.appVersion,
      dateTime: DateTime.now().toIso8601String(),
      rememberMe: false,
    );

    var loginEither = await loginUsecase(params);

    if (loginEither.isLeft()) {
      print(loginEither);
      handleError(loginEither);
      isLoadingNotifier.value = false;
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, previous) {
        _accountProvider.userDetails = response;
        isLoadingNotifier.value = false;
        if (response.userDetails.isVerified) {
          sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
            // Logger().v(sessionSeconds);

            sessionSeconds--;
            if (sessionSeconds == 0) {
              sessionTimer!.cancel();
              // onErrorMessage?.call(OnErrorMessageModel(message: 'session expired login again', backgroundColor: Colors.grey));
              isSessionExpired = true;
              await logOut();
              appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.authWrapperPageConfig);

              // move user to login

            }
          });
          clearFields();

          moveToHomePage();
        } else {
          onErrorMessage?.call(OnErrorMessageModel(message: 'Account not verified'));
          moveToOtpPage();
          _otpViewModel.generateOtp();
        }
      });
    }
  }

  Future<void> logOut() async {
    isLogOutLoadingNotifier.value = true;
    var logoutEither = await logoutUsecase.call(LogoutRequestModel(userId: _accountProvider.userDetails!.userDetails.id));
    if (logoutEither.isLeft()) {
      handleError(logoutEither);
      isLogOutLoadingNotifier.value = true;
    } else if (logoutEither.isRight()) {
      logoutEither.foldRight(null, (response, _) {
        ReceiverViewModel receiverViewModel = sl();
        CardsViewModel cardsViewModel = sl();
        receiverViewModel.emptyReceiverLists();
        cardsViewModel.emptyList();
        previousFilesViewModel.clearFiles();
        requiredFilesViewModel.clearFiles();
        homeViewModel.clearData();
        profileViewModel.clearData();
        updateProfileViewModel.clearFields();
        paymentDetailsViewModel.clearAllTextFields();

        // TODO: clear receivers list
        // TODO: clear cards list
        logoutResponseModel = response;
      });
      isLogOutLoadingNotifier.value = false;
    }
  }

  void clearFields() {
    emailController.clear();

    passwordController.clear();
  }

  // Methods
  void onEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  void onPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onObsecureChange() {
    obsecureTextNotifier.value = !obsecureTextNotifier.value;
  }

  String? validateEmail(String? value) {
    if (!isButtonPressed) {
      return null;
    }
    isEmailError = true;
    var result = FormValidators.validateEmail(value);
    if (result == null) {
      isEmailError = false;
    }
    return result;
  }

  void onEmailChange(String value) {
    isButtonPressed = false;
    if (isEmailError) {
      formKey.currentState!.validate();
    }
  }

  String? validatePassword(String? value) {
    if (!isButtonPressed) {
      return null;
    }
    isPasswordError = true;
    var result = FormValidators.validateLoginPassword(value);
    if (result == null) {
      isPasswordError = false;
    }
    return result;
  }

  void onPasswordChange(String value) {
    isButtonPressed = false;
    if (isPasswordError) {
      formKey.currentState!.validate();
    }
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

  // Page Moves
  void moveToGetEmailPage() {
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.getEmailPageConfig);
  }

  void moveToHomePage() {
    appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.homePageConfig);
  }

  void moveToOtpPage() {
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.otpPageConfig);
  }
}
