import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:password_strength/password_strength.dart';
import 'package:uremit/features/menu/security/models/change_password_request_model.dart';
import 'package:uremit/features/menu/security/usecases/change_password_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';

class SecurityViewModel extends ChangeNotifier {
  SecurityViewModel(this.changePasswordUsecase);

  // Usecases
  ChangePasswordUsecase changePasswordUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  ValueNotifier<bool> isPasswordStrengthVisible = ValueNotifier(false);
  ValueNotifier<String> passwordStrengthStr = ValueNotifier('');
  ValueNotifier<Color> passwordStrengthColor = ValueNotifier(Colors.transparent);
  ValueNotifier<bool> newPasswordObsecure = ValueNotifier(true);
  ValueNotifier<bool> confirmPasswordObsecure = ValueNotifier(true);
  ValueNotifier<bool> obsecureTextNotifier = ValueNotifier(true);

  bool isOldPasswordError = false;
  bool isSaveButtonPressed = false;

  ValueNotifier<bool> isPasswordIncorrect = ValueNotifier(false);

  bool isNewPasswordError = false;
  bool isConfirmPasswordError = false;
  bool isUpdateButtonPressed = false;

  // Properties
  final GlobalKey<FormState> securityFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String newPasswordLabelText = 'New Password';
  final String newPasswordHintText = 'Enter New Password';
  final TextEditingController newPasswordController = TextEditingController();
  final FocusNode newPasswordFocusNode = FocusNode();

  final String confirmPasswordLabelText = 'Confirm Password';
  final String confirmPasswordHintText = 'Enter Confirm Password';
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final String oldPasswordLabelText = 'Old Password';
  final String oldPasswordHintText = 'Enter Old Password';
  final TextEditingController oldPasswordController = TextEditingController();
  final FocusNode oldPasswordFocusNode = FocusNode();

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> changePassword(BuildContext context) async {
    isLoadingNotifier.value = true;

    var params = ChangePasswordRequestModel(
      userID: _accountProvider.userDetails!.userDetails.id,
      oldPassword: oldPasswordController.text,
      newPassword: confirmPasswordController.text,
    );

    var changePasswordEither = await changePasswordUsecase.call(params);

    if (changePasswordEither.isLeft()) {
      isPasswordIncorrect.value = true;
      isOldPasswordError = true;
      isLoadingNotifier.value = false;
      formKey.currentState!.validate();
      handleError(changePasswordEither);
    } else if (changePasswordEither.isRight()) {
      isOldPasswordError = false;
      isPasswordIncorrect.value = false;
      Navigator.of(context).pop();
      isPasswordStrengthVisible.value = false;
      clearFields();
      changePasswordEither.foldRight(null, (response, _) {
        onErrorMessage?.call(OnErrorMessageModel(message: response.changePasswordBody.message, backgroundColor: Colors.green));
      });
      isLoadingNotifier.value = false;
    }
  }

  // Methods
  String? validateNewPassword(String? value) {
    if (!isUpdateButtonPressed) {
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
    isUpdateButtonPressed = false;
    _checkPasswordStrength(value);
    if (isNewPasswordError) {
      securityFormKey.currentState!.validate();
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
    if (!isUpdateButtonPressed) {
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
    isUpdateButtonPressed = false;
    if (isConfirmPasswordError) {
      securityFormKey.currentState!.validate();
    }
  }

  String? validateOldPassword(String? value) {
    if (isPasswordIncorrect.value) {
      return 'Incorrect Password';
    }

    if (!isSaveButtonPressed) {
      return null;
    }
    isOldPasswordError = true;
    var result = FormValidators.validateLoginPassword(value);
    if (result == null) {
      isOldPasswordError = false;
    }
    return result;
  }

  void onOldPasswordChange(String value) {
    isPasswordIncorrect.value = false;
    isSaveButtonPressed = false;
    if (isOldPasswordError) {
      formKey.currentState!.validate();
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

  void onPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onObsecureChange() {
    obsecureTextNotifier.value = !obsecureTextNotifier.value;
  }

  void clearFields() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    oldPasswordController.clear();
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

// Page Moves
}
