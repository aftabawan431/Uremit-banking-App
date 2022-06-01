import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:uremit/features/payment/receiver_info/models/receiver_add_request_list_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_request_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_response_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/features/receivers/usecases/get_bank_list_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../services/models/no_params.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../../../menu/update_profile/models/get_countries_response_model.dart';
import '../../../../menu/update_profile/usecases/get_countries_usecase.dart';
import '../../usecase/receiver_add_usecase.dart';

class ReceiverInfoViewModel extends ChangeNotifier {
  ReceiverInfoViewModel({required this.getCountriesUsecase, required this.getBankListUsecase, required this.receiverAddUsecase});
  // Usecases
  GetCountriesUsecase getCountriesUsecase;
  ReceiverAddUsecase receiverAddUsecase;
  GetBankListResponseModel? getBanks;
  GetBankListUsecase getBankListUsecase;
  GetBankListResponseModelBody? getBankListResponseModelBody;
  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> status = ValueNotifier(false);
  ValueNotifier<bool> isCountryLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isBanksListLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isReceiverAddLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> middleNameNotifier = ValueNotifier(true);

  bool isReceiverInfoPageChange = false;
  bool isNickNameError = false;
  bool isFirstNameError = false;
  bool isMiddleNameError = false;
  bool isLastNameError = false;
  bool isReceiverCountryError = false;
  bool isEmailError = false;
  bool isPhoneError = false;

  // Properties
  final GlobalKey<FormState> receiverInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> receiverBankInfoFormKey = GlobalKey<FormState>();
  PageController pageController = PageController();

  final FocusNode nickNameFocusNode = FocusNode();
  final String nickNameLabelText = 'Nick Name';
  final String nickNameHintText = 'Enter Nick Name';
  final TextEditingController nickNameController = TextEditingController();

  final String firstNameLabelText = 'First Name';
  final String firstNameHintText = 'Enter First Name';
  final TextEditingController firstNameController = TextEditingController();
  final FocusNode firstNameFocusNode = FocusNode();

  final String middleNameLabelText = 'Middle Name';
  final String middleNameHintText = 'Enter Middle Name';
  final TextEditingController middleNameController = TextEditingController();
  final FocusNode middleNameFocusNode = FocusNode();

  final String lastNameLabelText = 'Last Name';
  final String lastNameHintText = 'Enter Last Name';
  final TextEditingController lastNameController = TextEditingController();
  final FocusNode lastNameFocusNode = FocusNode();

  final FocusNode receiverCountryFocusNode = FocusNode();
  final String receiverCountryLabelText = 'Country';
  final String receiverCountryHintText = 'Select Country';
  final TextEditingController receiverCountryController = TextEditingController();

  final FocusNode receiverEmailFocusNode = FocusNode();
  final String receiverEmailLabelText = 'Email';
  final String receiverEmailHintText = 'Enter Email';
  final TextEditingController receiverEmailController = TextEditingController();

  final String phoneLabelText = 'Contact Number';
  final String phoneHintText = '+62xxxxxxxxxx';
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  RadioGroupController accountTypeController = RadioGroupController();
  final List<String> accountTypeValues = ['IBAN', 'Account Number'];

  final FocusNode accountHolderNameFocusNode = FocusNode();
  final String accountHolderNameLabelText = 'Account Holder Name';
  final String accountHolderNameHintText = 'Account Holder Name';
  final TextEditingController accountHolderNameController = TextEditingController();

  final FocusNode bankFocusNode = FocusNode();
  final String bankLabelText = 'Bank';
  final String bankHintText = 'Enter Bank';
  String? bankId = '';
  final TextEditingController bankController = TextEditingController();

  final FocusNode accountNumberFocusNode = FocusNode();
  final String accountNumberLabelText = 'Account Number';
  final String accountNumberHintText = 'Enter Account Number';
  final TextEditingController accountNumberController = TextEditingController();

  String countryId = '';
  // Getters
  AppState appState = GetIt.I.get<AppState>();
  ReceiverInfoViewModel get receiverInfoViewModel => sl();

  AccountProvider get _accountProvider => sl();
  GetCountriesResponseModel? countriesList;
  CountriesBody? receiverCountry;

  clearFields() {
    nickNameController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    receiverEmailController.text = '';
    phoneController.text = '';
  }
  // Usecase Calls

  Future<void> addReceiver(BuildContext context, {bool hasBank = false}) async {
    var params;
    isReceiverAddLoadingNotifier.value = true;
    if (hasBank == true) {
      params = ReceiverAddRequestListModel(
          userID: _accountProvider.userDetails!.userDetails.id,
          nickName: nickNameController.text,
          firstName: firstNameController.text,
          middleName: middleNameController.text,
          lastName: lastNameController.text,
          email: receiverEmailController.text,
          phone: phoneController.text,
          countryID: '',
          country: countryId,
          bank: ReceiverAddRequestListBank(
              bankCode: bankController.text, accountNo: accountNumberController.text, accountTitle: accountHolderNameController.text, branchCode: '', isIban: 0));
    } else {
      params = ReceiverAddRequestListModel(
          userID: _accountProvider.userDetails!.userDetails.id,
          nickName: nickNameController.text,
          firstName: firstNameController.text,
          middleName: middleNameController.text,
          lastName: lastNameController.text,
          email: receiverEmailController.text,
          phone: phoneController.text,
          countryID: '',
          country: countryId,
          bank: ReceiverAddRequestListBank(bankCode: '', accountNo: '', accountTitle: '', branchCode: '', isIban: 0));
    }
    var addReceiverEither = await receiverAddUsecase.call(params);

    if (addReceiverEither.isLeft()) {
      handleError(addReceiverEither);
      isReceiverAddLoadingNotifier.value = false;
    } else if (addReceiverEither.isRight()) {
      addReceiverEither.foldRight(null, (response, _) {
        isReceiverAddLoadingNotifier.value = false;
        clearAddReceiverInfo();
        context.read<ReceiverViewModel>().getReceiverList(recall: true);
        onErrorMessage?.call(
          OnErrorMessageModel(message: 'Receiver Added Successfully', backgroundColor: Colors.green),
        );
        Logger().i(response);
      });
    }
  }

  clearAddReceiverInfo() {
    nickNameController.clear();
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    receiverCountryController.clear();
    receiverEmailController.clear();
    phoneController.clear();
  }

  Future<void> getReceiverCountries() async {
    if (countriesList != null) {
      return;
    }

    isCountryLoadingNotifier.value = true;

    var getReceiverCountriesEither = await getCountriesUsecase.call(NoParams());

    if (getReceiverCountriesEither.isLeft()) {
      handleError(getReceiverCountriesEither);
      isCountryLoadingNotifier.value = false;
    } else if (getReceiverCountriesEither.isRight()) {
      getReceiverCountriesEither.foldRight(null, (response, _) {
        countriesList = response;
      });
      isCountryLoadingNotifier.value = false;
    }
  }

  Future<void> getBanksList(String countryId) async {
    if (countryId == '-1') {
      return;
    }

    isBanksListLoadingNotifier.value = true;

    var getBanksEither = await getBankListUsecase(GetBankListRequestModel(countryId));

    if (getBanksEither.isLeft()) {
      print('aftab1');
      handleError(getBanksEither);
      isBanksListLoadingNotifier.value = false;
    } else if (getBanksEither.isRight()) {
      print('awan');
      getBanksEither.foldRight(null, (response, _) {
        getBanks = response;
      });
      isBanksListLoadingNotifier.value = false;
    }
  }

  // Methods

  bool validateReceiverInfo() {
    isReceiverInfoPageChange = true;

    return receiverInfoFormKey.currentState!.validate();
  }

  bool validateBankInfo() {
    return receiverInfoFormKey.currentState!.validate();
  }

  void onNickNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(firstNameFocusNode);
  }

  void onFirstNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(middleNameFocusNode);
  }

  void onMiddleNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(lastNameFocusNode);
  }

  void onMiddleCheckboxClicked(bool? value) {
    middleNameNotifier.value = value ?? false;
  }

  void onLastNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(receiverCountryFocusNode);
  }

  void onReceiverCountrySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(receiverEmailFocusNode);
  }

  void onReceiverEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(phoneFocusNode);
  }

  void onContactSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onBankSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(accountNumberFocusNode);
  }

  String? validateNickName(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isNickNameError = true;
    var result = FormValidators.validateName(value?.trim());
    if (result == null) {
      isNickNameError = false;
    }
    return result;
  }

  void onNickNameChange(String value) {
    isReceiverInfoPageChange = false;
    if (isNickNameError) {
      receiverInfoFormKey.currentState!.validate();
    }
  }

  String? validateFirstName(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isFirstNameError = true;
    var result = FormValidators.validateName(value?.trim());
    if (result == null) {
      isFirstNameError = false;
    }
    return result;
  }

  void onFirstNameChange(String value) {
    isReceiverInfoPageChange = false;
    if (isFirstNameError) {
      receiverInfoFormKey.currentState!.validate();
    }
  }

  String? validateMiddleName(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isMiddleNameError = true;
    var result = FormValidators.validateName(value?.trim());
    if (result == null) {
      isMiddleNameError = false;
    }
    return result;
  }

  void onMiddleNameChange(String value) {
    isReceiverInfoPageChange = false;
    if (isMiddleNameError) {
      receiverInfoFormKey.currentState!.validate();
    }
  }

  String? validateLastName(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isLastNameError = true;
    var result = FormValidators.validateName(value?.trim());
    if (result == null) {
      isLastNameError = false;
    }
    return result;
  }

  void onLastNameChange(String value) {
    isReceiverInfoPageChange = false;
    if (isLastNameError) {
      receiverInfoFormKey.currentState!.validate();
    }
  }

  String? validateReceiverCountry(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isReceiverCountryError = true;
    var result = FormValidators.validateCountry(value?.trim());
    if (result == null) {
      isReceiverCountryError = false;
    }
    return result;
  }

  void onReceiverCountryChange(String value) {
    isReceiverInfoPageChange = false;
    if (isReceiverCountryError) {
      receiverInfoFormKey.currentState!.validate();
    }
  }

  String? validateEmail(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isEmailError = true;
    var result = FormValidators.validateEmail(value?.trim());
    if (result == null) {
      isEmailError = false;
    }
    return result;
  }

  String? validateAccountNumber(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }

    var result = FormValidators.validateAccountNumber(value?.trim());

    return result;
  }

  String? validateBank(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }

    var result = FormValidators.validateBank(value?.trim());

    return result;
  }

  void onEmailChange(String value) {
    isReceiverInfoPageChange = false;
    if (isEmailError) {
      receiverInfoFormKey.currentState!.validate();
    }
  }

  String? validatePhone(String? value) {
    if (!isReceiverInfoPageChange) {
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
    isReceiverInfoPageChange = false;
    if (isPhoneError) {
      receiverInfoFormKey.currentState!.validate();
    }
  }

  validatePaymentDetails() {
    isReceiverInfoPageChange = true;
    receiverInfoFormKey.currentState!.validate();
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold(
        (l) => onErrorMessage?.call(
              OnErrorMessageModel(message: l.message),
            ),
        (r) => null);
  }

// Page Moves
}
