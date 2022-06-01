import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:password_strength/password_strength.dart';
import 'package:uremit/features/authentication/registration/models/registration_request_model.dart';
import 'package:uremit/features/authentication/registration/usecases/registration_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/router/models/page_action.dart';
import 'package:uremit/utils/router/models/page_config.dart';

import '../../../../../app/globals.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../../auth_wrapper/presentation/manager/auth_wrapper_view_model.dart';

class RegistrationViewModel extends ChangeNotifier {
  RegistrationViewModel(this.registrationUsecase);

  // Usecases
  RegistrationUsecase registrationUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> obsecureTextNotifier = ValueNotifier(true);
  ValueNotifier<bool> referralCodeCheckNotifier = ValueNotifier(false);
  ValueNotifier<bool> promotionalCheckNotifier = ValueNotifier(false);
  ValueNotifier<bool> isPasswordStrengthVisible = ValueNotifier(false);
  ValueNotifier<String> passwordStrengthStr = ValueNotifier('');
  ValueNotifier<Color> passwordStrengthColor = ValueNotifier(Colors.transparent);

  bool isEmailError = false;
  bool isPasswordError = false;
  bool isPhoneError = false;
  bool isButtonPressed = false;

  // Properties
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String emailLabelText = 'Email';
  final String emailHintText = 'Enter Email Address';
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final String passwordLabelText = 'Password';
  final String passwordHintText = 'Enter Password';
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final String phoneLabelText = 'Phone';
  final String phoneHintText = '+62 xxxxxxxxx';
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AuthWrapperViewModel get _authWrapperViewModel => sl();

  // Usecase Calls
  Future<void> registerUser() async {
    _authWrapperViewModel.currentIndex = 1;
    isLoadingNotifier.value = true;

    var params = RegistrationRequestModel(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: passwordController.text,
      countryId: 0,
      companyId: 1,
      isSubscribed: false,
      referralCode: '',
      phoneNumber: phoneController.text.replaceAll('-', ''),
    );

    var registrationEither = await registrationUsecase.call(params);

    if (registrationEither.isLeft()) {
      handleError(registrationEither);
      isLoadingNotifier.value = false;
    } else if (registrationEither.isRight()) {
      registrationEither.foldRight(null, (response, previous) {
        onErrorMessage?.call(OnErrorMessageModel(message: response.registrationDetails.message, backgroundColor: Colors.green));
      });
      isLoadingNotifier.value = false;
      moveToOtp();
    }
  }

  // Methods
  void onEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  void onPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(phoneFocusNode);
  }

  void onPhoneSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onObsecureChange() {
    obsecureTextNotifier.value = !obsecureTextNotifier.value;
  }

  void referralCheckChange(bool? value) {
    referralCodeCheckNotifier.value = value ?? false;
  }

  void promotionalCheckChange(bool? value) {
    promotionalCheckNotifier.value = value ?? false;
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
    var result = FormValidators.validateRegistrationPassword(value);
    if (result == null) {
      isPasswordError = false;
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

  void onPasswordChange(String value) {
    isButtonPressed = false;
    _checkPasswordStrength(value);
    if (isPasswordError) {
      formKey.currentState!.validate();
    }
  }

  String? validatePhone(String? value) {
    if (!isButtonPressed) {
      return null;
    }
    isPhoneError = true;
    var result = FormValidators.validatePhone(value!.replaceAll('-', ''));
    if (result == null) {
      isPhoneError = false;
    }
    return result;
  }

  void onPhoneChange(String value) {
    isButtonPressed = false;
    if (isPhoneError) {
      formKey.currentState!.validate();
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

  void resetFields() {
    isPasswordStrengthVisible.value = false;
    passwordStrengthStr.value = '';
    passwordStrengthColor.value = Colors.transparent;

    isEmailError = false;
    isPasswordError = false;
    isPhoneError = false;
    isButtonPressed = false;

    emailController.clear();
    phoneController.clear();
    passwordController.clear();
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

  // Page Moves
  void moveToOtp() {
    // resetFields();
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.otpPageConfig);
  }
}
