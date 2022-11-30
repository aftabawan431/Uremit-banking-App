import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/manager/payment_wrapper_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/features/payment/receiver_info/models/get_admistrative_charges_list_request_model.dart';
import 'package:uremit/features/payment/receiver_info/models/get_uremit_banks_countires_response_model.dart';
import 'package:uremit/features/payment/receiver_info/models/receiver_add_request_list_model.dart';
import 'package:uremit/features/payment/receiver_info/usecase/get_administrative_charges_list_usecase.dart';
import 'package:uremit/features/payment/receiver_info/usecase/get_uremit_bank_countries_usecase.dart';
import 'package:uremit/features/payment/receiver_info/usecase/validate_bank_usecase.dart';
import 'package:uremit/features/receivers/models/get_bank_list_request_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_response_model.dart';
import 'package:uremit/features/receivers/models/validate_bank_response_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/features/receivers/usecases/get_bank_list_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/encryption/encryption.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../services/models/no_params.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../../../receivers/models/validate_bank_request_model.dart';
import '../../usecase/receiver_add_usecase.dart';

class ReceiverInfoViewModel extends ChangeNotifier {
  ReceiverInfoViewModel(
      {required this.getUremitBanksCountriesUsecase,
      required this.getAdministrativeChargesListUsecase,
      required this.validateBankUsecase,
      required this.getBankListUsecase,
      required this.receiverAddUsecase});
  // Usecases
  GetUremitBanksCountriesUsecase getUremitBanksCountriesUsecase;
  ReceiverAddUsecase receiverAddUsecase;
  ValidateBankUsecase validateBankUsecase;
  GetAdministrativeChargesListUsecase getAdministrativeChargesListUsecase;
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
  ValueNotifier<bool> isValidateLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isGetAdminFeeLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> middleNameNotifier = ValueNotifier(true);
  ValueNotifier<bool> lastNameNotifier = ValueNotifier(true);
  ValueNotifier<bool> isNepaliBank = ValueNotifier(false);
  ValueNotifier<String?> selectedPhoneNumber = ValueNotifier('+61');


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
  final GlobalKey<FormState> receiverAccountNameInfoFormKey =
      GlobalKey<FormState>();
  PageController pageController = PageController();

  final FocusNode nickNameFocusNode = FocusNode();
  final String nickNameLabelText = 'Nick Name';
  final String nickNameHintText = 'Enter Nick Name';
  final TextEditingController nickNameController = TextEditingController();

  final String firstNameLabelText = 'First Name';
  final String firstNameHintText = 'Enter First Name';
  final TextEditingController firstNameController = TextEditingController();
  final FocusNode firstNameFocusNode = FocusNode();

  final String addressLabelText = 'Address';
  final String addressHintText = 'Enter Address';
  final TextEditingController addressController = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();

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
  final TextEditingController receiverCountryController =
      TextEditingController();

  final FocusNode receiverEmailFocusNode = FocusNode();
  final String receiverEmailLabelText = 'Email';
  final String receiverEmailHintText = 'Enter email';
  final TextEditingController receiverEmailController = TextEditingController();

  final FocusNode receiverRelationshipFocusNode = FocusNode();
  final String receiverRelationshipLabelText = 'Relationship';
  final String receiverRelationshipHintText = 'Enter Relationship';
  final TextEditingController receiverRelationshipController =
      TextEditingController();

  final String phoneLabelText = 'Contact Number';
  final String phoneHintText = 'xxxxxxxxxxxx';
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  RadioGroupController accountTypeController = RadioGroupController();
  final List<String> accountTypeValues = ['IBAN', 'Account Number'];

  final FocusNode accountHolderNameFocusNode = FocusNode();
  final String accountHolderNameLabelText = 'Account Holder Name';
  final String accountHolderNameHintText = 'Account Holder Name';
  final TextEditingController accountHolderNameController =
      TextEditingController();

  final FocusNode bankFocusNode = FocusNode();
  final String bankLabelText = 'Bank';
  final String bankHintText = 'Enter Bank';
  String? bankId = '';
  final TextEditingController bankController = TextEditingController();

  final FocusNode accountNumberFocusNode = FocusNode();
  final String accountNumberLabelText = 'Account Number';
  final String accountNumberHintText = 'Enter Account Number';
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankCodeController = TextEditingController();
  final TextEditingController branchCodeController = TextEditingController();

  String countryId = '';
  String countryCode = '';
  double adminFee = 0.0;

  double get adminFeeGet {
    ReceiptScreenViewModel receiptScreenViewModel = sl();
    if (receiptScreenViewModel.fromChangePaymentMethod ||
        receiptScreenViewModel.isRepeatTransaction) {
      return receiptScreenViewModel.updateTransaction!.adminFee;
    }

    return adminFee;
  }

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  ReceiverInfoViewModel get receiverInfoViewModel => sl();

  AccountProvider get _accountProvider => sl();
  GetUremitBanksCountriesResponseModel? countriesList;
  GetUremitBanksCountriesResponseModelBody? receiverCountry;
  ValidateBankResponseModelBody? validateBankResponseModelBody;

  clearFields() {
    nickNameController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    receiverEmailController.text = '';
    phoneController.text = '';
    selectedPhoneNumber.value='+61';
  }
  // Usecase Calls

  Future<void> addReceiver(BuildContext context, {bool hasBank = false}) async {
    var params;
    isReceiverAddLoadingNotifier.value = true;
    if (hasBank == true) {
      params = ReceiverAddRequestListModel(
          relationShip: receiverRelationshipController.text,
          userID: _accountProvider.userDetails!.userDetails.id,
          nickName: nickNameController.text,
          firstName: firstNameController.text,
          address: addressController.text,
          middleName:
              middleNameNotifier.value == true ? '' : middleNameController.text,
          lastName:lastNameNotifier.value? '':lastNameController.text,
          email: receiverEmailController.text,
          // phone: countryCode + phoneController.text,
          phone:selectedPhoneNumber.value!+ phoneController.text,
          country: countryId,
          bank: ReceiverAddRequestListBank(
              bankCode: bankCodeController.text,
              accountNo: accountNumberController.text,
              accountTitle: accountHolderNameController.text,
              branchCode: branchCodeController.text,
              isIban: accountNumberController.text.length > 13 ? 1 : 0));
    } else {
      params = ReceiverAddRequestListModel(
          relationShip: receiverRelationshipController.text,
          userID: _accountProvider.userDetails!.userDetails.id,
          nickName: nickNameController.text,
          address: addressController.text,
          firstName: firstNameController.text,
          middleName:
              middleNameNotifier.value == true ? '' : middleNameController.text,
          lastName:lastNameNotifier.value? '':lastNameController.text,
          email: receiverEmailController.text,
          // phone: countryCode + phoneController.text,
          phone:selectedPhoneNumber.value!+ phoneController.text,
          country: countryId,
          bank: ReceiverAddRequestListBank(
              bankCode: '',
              accountNo: '',
              accountTitle: '',
              branchCode: '',
              isIban: 0));
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
          OnErrorMessageModel(
              message: 'Receiver Added Successfully',
              backgroundColor: Colors.green),
        );
        ReceiverViewModel receiverViewModel = sl();
        if (receiverViewModel.isPaymentReceiver == false) {
          receiverViewModel.moveToReceiversPage();
        } else {
          goBackToPaymentDetails();
        }

        Logger().i(response);
      });
    }
  }

  goBackToPaymentDetails() {
    PaymentWrapperViewModel provier = sl();
    provier.buttonTap(0);
  }

  Future<void> validateUserBank(
    BuildContext context,
  ) async {
    var params;
    isValidateLoadingNotifier.value = true;

    params = ValidateBankRequestModel(
      accountNumber: accountNumberController.text.trim(),
      bankId: bankId.toString(),
    );

    var validateBankEither = await validateBankUsecase.call(params);

    if (validateBankEither.isLeft()) {
      handleError(validateBankEither);
      isValidateLoadingNotifier.value = false;
    } else if (validateBankEither.isRight()) {
      validateBankEither.foldRight(null, (response, _) {
        isValidateLoadingNotifier.value = false;

        String titleOfAccount =
            response.validateBankResponseModelBody.titleOfAccount;
        ReceiverInfoViewModel receiverInfoViewModel = sl();
        String fullName =
            "${receiverInfoViewModel.firstNameController.text} ${receiverInfoViewModel.lastNameController.text}";
        accountHolderNameController.text =
            titleOfAccount.isEmpty ? fullName : titleOfAccount;
        bankCodeController.text =
            response.validateBankResponseModelBody.bankCode;
        branchCodeController.text =
            response.validateBankResponseModelBody.branchCode;
        isValidateLoadingNotifier.value = false;
        onErrorMessage?.call(
          OnErrorMessageModel(
              message: 'Validated', backgroundColor: Colors.green),
        );
        Logger().i(response);
      });
    }
  }

  Future<void> getAdminFee() async {
    var params;
    isGetAdminFeeLoadingNotifier.value = true;

    params = GetAdministrativeChargesListRequestModel(
        id: Encryption.encryptObject(receiverInfoViewModel.countryId));

    var getAdminFeeEither =
        await getAdministrativeChargesListUsecase.call(params);

    if (getAdminFeeEither.isLeft()) {
      handleError(getAdminFeeEither);
      isGetAdminFeeLoadingNotifier.value = false;
    } else if (getAdminFeeEither.isRight()) {
      getAdminFeeEither.foldRight(null, (response, _) {
        isGetAdminFeeLoadingNotifier.value = false;
        PaymentDetailsViewModel paymentDetailsViewModel = sl();
        adminFee = 0.0;
        for (var i = 0; i < response.Body.length; i++) {
          if (double.parse(paymentDetailsViewModel.sendMoneyController.text) >=
                  response.Body[i].startAmount &&
              double.parse(paymentDetailsViewModel.sendMoneyController.text) <=
                  response.Body[i].endAmount) {
            adminFee = response.Body[i].charges.toDouble();
            break;
          }
          print('hey vro this is admin fee $adminFee');
        }
        print('hi');
        appState.currentAction = PageAction(
            state: PageState.addPage,
            page: PageConfigs.receiptScreenPageConfig);

        // Logger().w('hello this is the response of getAdminFee ${response.Body}');
        // print('hello this is the response of getAdminFee ${response.Body}');
        isGetAdminFeeLoadingNotifier.value = false;
        onErrorMessage?.call(
          OnErrorMessageModel(
              message: 'Got Admin Fee', backgroundColor: Colors.green),
        );
        Logger().i(response);
      });
    }
  }

  clearAddReceiverInfo() {
    nickNameController.clear();
    middleNameNotifier.value=false;
    lastNameNotifier.value=false;
    firstNameController.clear();
    middleNameController.clear();
    addressController.clear();
    lastNameController.clear();
    receiverCountryController.clear();
    receiverEmailController.clear();
    phoneController.clear();
    bankId == '';
    bankController.clear();
    receiverRelationshipController.clear();
    accountNumberController.clear();
    accountHolderNameController.clear();
  }

  Future<void> getUremitBankReceiverCountries() async {
    if (countriesList != null) {
      return;
    }

    isCountryLoadingNotifier.value = true;

    var getReceiverCountriesEither =
        await getUremitBanksCountriesUsecase.call(NoParams());

    if (getReceiverCountriesEither.isLeft()) {
      handleError(getReceiverCountriesEither);
      isCountryLoadingNotifier.value = false;
    } else if (getReceiverCountriesEither.isRight()) {
      getReceiverCountriesEither.foldRight(null, (response, _) {
        countriesList = response;
        print('these are the uremit countries $countriesList');
      });
      isCountryLoadingNotifier.value = false;
    }
  }

  Future<void> getBanksList(String countryId) async {
    if (countryId == '-1') {
      return;
    }

    isBanksListLoadingNotifier.value = true;

    var getBanksEither =
        await getBankListUsecase(GetBankListRequestModel(countryId));

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
  bool isBankInfoPageChange = false;
  void validateFirstPage() {
    isReceiverInfoPageChange = true;
    if (!receiverInfoFormKey.currentState!.validate()) {
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOutCubic);
    }
  }

  void validateSecondPage() {
    isBankInfoPageChange = true;
    if (!receiverBankInfoFormKey.currentState!.validate()) {
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOutCubic);
    }
  }

  void onPageChange(int index) {
    if (index > 0 && index <= 1) {
      validateFirstPage();
      ReceiverInfoViewModel receiverInfoViewModel=sl();
      FocusScope.of(navigatorKeyGlobal.currentContext!).requestFocus(receiverInfoViewModel.bankFocusNode);




    } else if (index > 1 && index <= 2) {
      validateSecondPage();
    }
  }

  bool validateReceiverInfo() {
    isReceiverInfoPageChange = true;

    return receiverInfoFormKey.currentState!.validate();
  }

  bool validateBankInfo() {
    return receiverBankInfoFormKey.currentState!.validate();
  }

  bool validateAccountNameInfo() {
    return receiverAccountNameInfoFormKey.currentState!.validate();
  }

  void onNickNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(firstNameFocusNode);
  }

  void onFirstNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(middleNameFocusNode);
  }

  void onAddressSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onMiddleNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(lastNameFocusNode);
  }

  void onMiddleCheckboxClicked(bool? value) {
    middleNameNotifier.value = value ?? false;
  }

  void onLastCheckboxClicked(bool? value) {
    lastNameNotifier.value = value ?? false;
  }

  void onLastNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(receiverCountryFocusNode);
  }

  void onReceiverCountrySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(receiverRelationshipFocusNode);
  }

  void onReceiverEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(phoneFocusNode);
  }

  void onReceiverRelationshipSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(receiverEmailFocusNode);
  }

  void onContactSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(addressFocusNode);
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

  String? validateAddress(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isFirstNameError = true;
    var result = FormValidators.validateAddress(value?.trim());
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
  void onAddressChange(String value) {
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

  String? validateRelationShip(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }
    isEmailError = true;
    var result = FormValidators.validateFiled(value?.trim());
    if (result == null) {
      isEmailError = false;
    }
    return result;
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
    var result = FormValidators.validatePhone(selectedPhoneNumber.value, value);
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

  void loadProfileData(ValidateBankResponseModelBody? bankDetails) {
    if (bankDetails != null) {
      accountNumberController.text = bankDetails.titleOfAccount;
    }
  }

// Page Moves
}
