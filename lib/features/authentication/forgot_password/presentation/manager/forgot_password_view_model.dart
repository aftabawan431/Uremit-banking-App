import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:password_strength/password_strength.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uremit/features/authentication/forgot_password/models/forgot_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/usecases/forgot_password_usecase.dart';
import 'package:uremit/features/authentication/forgot_password/usecases/reset_password_usecase.dart';
import 'package:uremit/features/authentication/forgot_password/usecases/validate_otp_usecase.dart';
import 'package:uremit/features/authentication/otp/presentation/manager/otp_view_model.dart';
import 'package:uremit/features/authentication/otp/usecases/generate_otp_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/router/models/page_action.dart';
import 'package:uremit/utils/router/models/page_config.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/widgets/dialogs/success_dialog.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../../otp/models/generate_otp_request_model.dart';
import '../../models/validate_otp_request_model.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  ForgotPasswordViewModel({required this.forgotPasswordUsecase, required this.validateOtpUsecase, required this.generateOtpUsecase, required this.resetPasswordUsecase});

  // Usecases
  ForgotPasswordUsecase forgotPasswordUsecase;
  ValidateOtpUsecase validateOtpUsecase;
  GenerateOtpUsecase generateOtpUsecase;
  ResetPasswordUsecase resetPasswordUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isForgotPasswordLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isGeneratePasswordLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isResetPasswordLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isPasswordStrengthVisible = ValueNotifier(false);
  ValueNotifier<String> passwordStrengthStr = ValueNotifier('');
  ValueNotifier<Color> passwordStrengthColor = ValueNotifier(Colors.transparent);
  ValueNotifier<bool> newPasswordObsecure = ValueNotifier(true);
  ValueNotifier<bool> confirmPasswordObsecure = ValueNotifier(true);

  bool isEmailError = false;
  bool isButtonPressed = false;
  bool isConfirmButtonPressed = false;
  bool isNewPasswordError = false;
  bool isConfirmPasswordError = false;

  bool otpTimer =true;
  startTimer()async{
    otpTimer =false;
    notifyListeners();
  }

  // Properties
  final GlobalKey<FormState> getEmailFormKey = GlobalKey<FormState>(debugLabel: 'GET-EMAIL-FORM-KEY');
  final GlobalKey<FormState> restForgotPasswordFormKey = GlobalKey<FormState>(debugLabel: 'RESET-FORGOT-PASSWORD-FORM-KEY');

  final TextEditingController otpController = TextEditingController();
  final StreamController<ErrorAnimationType> errorStream = StreamController<ErrorAnimationType>.broadcast();

  final String emailLabelText = 'Email';
  final String emailHintText = 'Enter Email Address';
  // final TextEditingController emailController = TextEditingController(text: 'aftabawan431@gmail.com');
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final String newPasswordLabelText = 'New Password';
  final String newPasswordHintText = 'Enter New Password';
  final TextEditingController newPasswordController = TextEditingController();
  final FocusNode newPasswordFocusNode = FocusNode();

  final String confirmPasswordLabelText = 'Confirm Password';
  final String confirmPasswordHintText = 'Re-Enter Your Password';
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  String otpCode = '';
  String userId = '';

  // Getters
  AppState appState = GetIt.I.get<AppState>();

  // Usecase Calls
  Future<void> forgotPassword() async {
    isForgotPasswordLoadingNotifier.value = true;

    var params = ForgotPasswordRequestModel(email: emailController.text);

    var forgotPasswordEither = await forgotPasswordUsecase.call(params);

    if (forgotPasswordEither.isLeft()) {
      handleError(forgotPasswordEither);
      isForgotPasswordLoadingNotifier.value = false;
    } else if (forgotPasswordEither.isRight()) {
      onErrorMessage?.call(OnErrorMessageModel(message: 'OTP sent!', backgroundColor: Colors.grey));
      moveToForgotOtpPage();
      isForgotPasswordLoadingNotifier.value = false;
    }
  }
  otpTimerChange(bool value){
    otpTimer=value;
    notifyListeners();
  }
  Future<void> generateOtp() async {
    isGeneratePasswordLoadingNotifier.value = true;
    otpTimerChange(true);

    var params = GenerateOtpRequestModel(emailController.text, 2);

    var generateOtpEither = await generateOtpUsecase.call(params);

    if (generateOtpEither.isLeft()) {
      handleError(generateOtpEither);

      notifyListeners();
    } else if (generateOtpEither.isRight()) {
      onErrorMessage?.call(OnErrorMessageModel(message: 'OTP sent!', backgroundColor: Colors.grey));
      isGeneratePasswordLoadingNotifier.value = false;

    }
  }

  Future<void> validateOtp() async {
    isGeneratePasswordLoadingNotifier.value = true;

    var params = ValidateOtpRequestModel(otpCode: otpController.text, otpType: 2, email: emailController.text);

    var validateOtpEither = await validateOtpUsecase.call(params);

    if (validateOtpEither.isLeft()) {
      handleError(validateOtpEither);
      isGeneratePasswordLoadingNotifier.value = false;
    } else if (validateOtpEither.isRight()) {
      validateOtpEither.foldRight(null, (response, _) {
        if (response.otpBody.result) {
          onErrorMessage?.call(OnErrorMessageModel(message: 'OTP Verified', backgroundColor: Colors.green));
          otpCode = otpController.text;
          userId = response.otpBody.userID;
          moveToResetForgotPasswordPage();
        } else {
          onErrorMessage?.call(OnErrorMessageModel(message: 'Invalid OTP'));
          errorStream.sink.add(ErrorAnimationType.shake);
        }
      });
      isGeneratePasswordLoadingNotifier.value = false;
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    isResetPasswordLoadingNotifier.value = true;

    var params = ResetPasswordRequestModel(password: confirmPasswordController.text, userId: userId, otpCode: otpCode);

    var validateOtpEither = await resetPasswordUsecase.call(params);

    if (validateOtpEither.isLeft()) {
      handleError(validateOtpEither);
      isResetPasswordLoadingNotifier.value = false;
    } else if (validateOtpEither.isRight()) {
      isResetPasswordLoadingNotifier.value = false;
      validateOtpEither.foldRight(null, (response, _) {
        onErrorMessage?.call(OnErrorMessageModel(message: response.resetPasswordBody.message, backgroundColor: Colors.green));
        moveToAuthPages(context);
      });
    }
  }

  resetFields() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    isPasswordStrengthVisible.value = false;
    passwordStrengthStr.value = '';
    passwordStrengthColor.value = Colors.transparent;
  }

  // Methods
  void onEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
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
      getEmailFormKey.currentState!.validate();
    }
  }

  void onCompleted(String value) {
    validateOtp();
  }

  void onChanged(String value) {}

  bool beforeTextPaste(String? value) {
    return true;
  }

  void clearGetEmailFields() {
    emailController.clear();
  }

  void clearForgotOtpFields() {
    otpController.clear();
  }

  String? validateNewPassword(String? value) {
    if (!isConfirmButtonPressed) {
      return null;
    }
    isNewPasswordError = true;
    var result = FormValidators.validateRegistrationPassword(value);
    if (result == null) {
      isNewPasswordError = false;
    }
    if (result?.isEmpty ?? false) {
      onErrorMessage?.call(
        OnErrorMessageModel(
          message: 'Password must be of minimum 6 characters, at least one uppercase letter, one lowercase letter, one number and one special character',
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    return result;
  }

  void onNewPasswordChange(String value) {
    isConfirmButtonPressed = false;
    _checkPasswordStrength(value);
    if (isNewPasswordError) {
      restForgotPasswordFormKey.currentState!.validate();
    }
  }

  void _checkPasswordStrength(String value) {
    if (value.isEmpty) {
      isPasswordStrengthVisible.value = false;
    } else {
      var passwordStrength = estimatePasswordStrength(value);
      if (passwordStrength >= 0 && passwordStrength <= 0.33) {
        passwordStrengthColor.value = const Color(0xFFC40808);
        passwordStrengthStr.value = 'Weak Password';
      } else if (passwordStrength > 0.33 && passwordStrength <= 0.67) {
        passwordStrengthColor.value = const Color(0xFFE28111);
        passwordStrengthStr.value = 'Medium Password';
      } else if (passwordStrength > 0.67 && passwordStrength <= 1) {
        passwordStrengthColor.value = const Color(0xFF6AC400);
        passwordStrengthStr.value = 'Strong Password';
      }
      isPasswordStrengthVisible.value = true;
    }
  }

  String? validateConfirmPassword(String? value) {
    if (!isConfirmButtonPressed) {
      return null;
    }
    isConfirmPasswordError = true;
    var result = FormValidators.validateConfirmPassword(value, newPasswordController.text);
    if (result == null) {
      isConfirmPasswordError = false;
    }
    return result;
  }

  void onConfirmPasswordChange(String value) {
    isConfirmButtonPressed = false;
    if (isConfirmPasswordError) {
      restForgotPasswordFormKey.currentState!.validate();
    }
  }

  void onNewPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
  }

  void onConfirmPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onNewObsecureChange() {
    newPasswordObsecure.value = !newPasswordObsecure.value;
  }

  void onConfirmObsecureChange() {
    confirmPasswordObsecure.value = !confirmPasswordObsecure.value;
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isForgotPasswordLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

  // Page Moves
  void moveToForgotOtpPage() {
    appState.currentAction = PageAction(state: PageState.replace, page: PageConfigs.forgotOtpPageConfig);
  }

  void moveToResetForgotPasswordPage() {
    appState.currentAction = PageAction(state: PageState.replace, page: PageConfigs.resetForgotPasswordPageConfig);
  }

  void moveToAuthPages(BuildContext context) {
    SuccessDialog successDialog = SuccessDialog(context);
    successDialog.show();
    Future.delayed(const Duration(seconds: 2), successDialog.hideDialog).then((_) {
      appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.authWrapperPageConfig);
    });
  }
}
