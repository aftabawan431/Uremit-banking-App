import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:uremit/features/payment/personal_info/usecase/set_profile_details_usecase.dart';
import 'package:uremit/services/models/no_params.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/constants/enums/attachment_type.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/encryption/encryption.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../../../menu/update_profile/models/countries_province_request_model.dart';
import '../../../../menu/update_profile/models/countries_province_response_model.dart';
import '../../../../menu/update_profile/models/doc_type_request_model.dart';
import '../../../../menu/update_profile/models/doc_type_response_model.dart';
import '../../../../menu/update_profile/models/get_countries_response_model.dart';
import '../../../../menu/update_profile/usecases/countries_province_usecase.dart';
import '../../../../menu/update_profile/usecases/doc_type_usecase.dart';
import '../../../../menu/update_profile/usecases/get_countries_usecase.dart';
import '../../../payment_wrapper/presentation/manager/payment_wrapper_view_model.dart';
import '../../models/set_profile_details_request_model.dart';

class ProfileInfoViewModel extends ChangeNotifier {
  ProfileInfoViewModel({required this.setProfileDetailsUsecase, required this.getCountriesUsecase, required this.countriesProvinceUsecase, required this.docTypeUsecase});

  // Usecases
  GetCountriesUsecase getCountriesUsecase;
  CountriesProvinceUsecase countriesProvinceUsecase;
  DocTypeUsecase docTypeUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> middleNameNotifier = ValueNotifier(false);
  ValueNotifier<bool> lastNameNotifier = ValueNotifier(false);
  ValueNotifier<bool> isCountryLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isProvinceLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isDocsLoadingNotifier = ValueNotifier(false);
  ValueNotifier<String?> selectedPhoneNumber = ValueNotifier('+61');


  bool isFirstNameError = false;
  bool isMiddleNameError = false;
  bool isLastNameError = false;
  bool isCobError = false;
  bool isOccupationError = false;
  bool isNationalityError = false;
  bool isPhoneError = false;
  bool isDobError = false;

  bool isAddressError = false;
  bool isPostalCodeError = false;
  bool isCityError = false;
  bool isProvinceError = false;

  bool isDocumentTypeError = false;
  bool isDocumentNumberError = false;
  bool isFrontSideError = false;
  bool isBackSideError = false;
  bool isExpiryDateError = false;
  bool isIssuingAuthorityError = false;
  bool isIssuingCountryError = false;
  bool isUtilityError = false;

  bool isPersonalPageChange = false;
  bool isAddressPageChange = false;
  bool isDocumentPageButtonPressed = false;

  // Properties
  PageController pageController = PageController();

  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> documentFormKey = GlobalKey<FormState>();

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

  final String cobLabelText = 'Country of Birth';
  final String cobHintText = 'Select the Country';
  final TextEditingController cobController = TextEditingController();
  String cobId = '';
  final FocusNode cobFocusNode = FocusNode();

  final String occupationLabelText = 'Occupation';
  final String occupationHintText = 'Enter Occupation';
  final TextEditingController occupationController = TextEditingController();
  final FocusNode occupationFocusNode = FocusNode();

  final String nationalityLabelText = 'Nationality';
  final String nationalityHintText = 'Select the Country';
  final TextEditingController nationalityController = TextEditingController();
  String nationalityId = '';
  final FocusNode nationalityFocusNode = FocusNode();

  final String phoneLabelText = 'Contact Number';
  final String phoneHintText = 'xxxx-xxxxxxx';
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  RadioGroupController genderRadioController = RadioGroupController();
  final List<String> genderValues = [
    'Male',
    'Female',
  ];

  DateTime dobDateTime = DateTime.now();
  final String dobLabelText = 'Date of Birth';
  final String dobHintText = 'yyyy-MM-dd';
  final TextEditingController dobController = TextEditingController();
  final FocusNode dobFocusNode = FocusNode();

  final String addressLabelText = 'Address';
  final String addressHintText = 'Enter Street Number and Name';
  final TextEditingController addressController = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();

  final String postalLabelText = 'Post Code';
  final String postalHintText = 'Enter Post Code';
  final TextEditingController postalController = TextEditingController();
  final FocusNode postalFocusNode = FocusNode();

  final String cityLabelText = 'Suburb';
  final String cityHintText = 'Enter Suburb';
  final TextEditingController cityController = TextEditingController();
  final FocusNode cityFocusNode = FocusNode();

  final String provinceLabelText = 'Province';
  final String provinceHintText = 'Select State';
  final TextEditingController provinceController = TextEditingController();
  String provinceId = '';

  final FocusNode provinceFocusNode = FocusNode();

  final String documentTypeLabelText = 'Document Type';
  final String documentTypeHintText = 'Select Document Type';
  final TextEditingController documentTypeController = TextEditingController();
  String documentId = '';
  final FocusNode documentTypeFocusNode = FocusNode();

  final String documentNumberLabelText = 'Document Number';
  final String documentNumberHintText = 'Enter Document Number';
  final TextEditingController documentNumberController = TextEditingController();
  final FocusNode documentNumberFocusNode = FocusNode();

  final String frontSideLabelText = 'Front Side';
  final String frontSideHintText = 'Upload Front Side';
  final TextEditingController frontSideController = TextEditingController();
  final FocusNode frontSideFocusNode = FocusNode();

  final String backSideLabelText = 'Back Side';
  final String backSideHintText = 'Upload Front Side';
  final TextEditingController backSideController = TextEditingController();
  final FocusNode backSideFocusNode = FocusNode();

  DateTime expiryDateTime = DateTime.now();
  final String expiryLabelText = 'Expiry Date';
  final String expiryHintText = 'Select Expiry Date';
  final TextEditingController expiryController = TextEditingController();
  final FocusNode expiryFocusNode = FocusNode();

  final String issuingAuthorityLabelText = 'Issuing Authority';
  final String issuingAuthorityHintText = 'Enter Issuing Authority';
  final TextEditingController issuingAuthorityController = TextEditingController();
  final FocusNode issuingAuthorityFocusNode = FocusNode();

  final String issuingCountryLabelText = 'Issuing Country';
  final String issuingCountryHintText = 'Select Issuing Country';
  final TextEditingController issuingCountryController = TextEditingController();
  String issuingId = '';
  final FocusNode issuingCountryFocusNode = FocusNode();

  final String utilityLabelText = 'Utility Bill';
  final String utilityHintText = 'Upload utility bill';
  final TextEditingController utilityController = TextEditingController();
  final FocusNode utilityFocusNode = FocusNode();

  GetCountriesResponseModel? countriesList;
  CountriesProvinceResponseModel? provincesList;
  DocTypeResponseModel? docTypeList;
  SetProfileDetailsUsecase setProfileDetailsUsecase;

  CountriesBody? nationalityCountry;
  CountriesBody? countryOfBirth;
  CountriesBody? issuingCountry;
  CountriesProvinceBody? province;

  DocTypeBody? docType;

  String? frontSide;
  String? backSide;
  String? utilityBill;
  List<PlatformFile> paths = [];

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  ProfileInfoViewModel get profileInfoViewModel => sl();

  // Usecase Calls
  Future<void> getCountries() async {
    if (countriesList != null) {
      return;
    }

    isCountryLoadingNotifier.value = true;

    var getCountriesEither = await getCountriesUsecase.call(NoParams());

    if (getCountriesEither.isLeft()) {
      handleError(getCountriesEither);
      isCountryLoadingNotifier.value = false;
    } else if (getCountriesEither.isRight()) {
      getCountriesEither.foldRight(null, (response, _) {
        countriesList = response;
      });
      isCountryLoadingNotifier.value = false;
    }
  }

  Future<void> getCountryProvince(String id) async {
    if (id == '-1') {
      return;
    }


    isProvinceLoadingNotifier.value = true;

    var provinceEither = await countriesProvinceUsecase.call(CountriesProvinceRequestModel(id));

    if (provinceEither.isLeft()) {
      handleError(provinceEither);
      isProvinceLoadingNotifier.value = false;
    } else if (provinceEither.isRight()) {
      provinceEither.foldRight(null, (response, _) {
        Logger().v(response.toJson());
        provincesList = response;

      });
      isProvinceLoadingNotifier.value = false;
    }
  }

  Future<void> getDocTypes() async {
    if (docTypeList != null) {
      return;
    }

    isDocsLoadingNotifier.value = true;

    var getDocsEither = await docTypeUsecase.call(const DocTypeRequestModel(1));

    if (getDocsEither.isLeft()) {
      handleError(getDocsEither);
      isDocsLoadingNotifier.value = false;
    } else if (getDocsEither.isRight()) {
      getDocsEither.foldRight(null, (response, _) {
        docTypeList = response;
      });
      isDocsLoadingNotifier.value = false;
    }
  }

  ValueNotifier<bool> saveNotifier = ValueNotifier(false);
  AccountProvider get _accountProvider => sl();

  Future<void> saveProfileData(BuildContext context) async {
    saveNotifier.value = true;

    var params = SetProfileDetailsRequestModel(
        userId: _accountProvider.userDetails!.userDetails.id.toString(),
        firstName: firstNameController.text,
        middleName:!middleNameNotifier.value? middleNameController.text:'',
        lastName:!lastNameNotifier.value? lastNameController.text:'',
        birthCountryId: cobId.toString(),
        occupation: occupationController.text,
        nationalityCountryId: nationalityId.toString(),
        genderId: genderRadioController.value == 'Female' ? 1 : 0,
        phoneNumber:  selectedPhoneNumber.value!+phoneController.text,
        dob: dobController.text,
        address: addressController.text,
        postalCode: postalController.text,
        city: cityController.text,
        province: provinceId.toString(),
        attachment: [
          Attachment(
            id: ''.toString(),
            FrontFile: frontSide == null ? '' : frontSide!,
            BackFile: backSide == null ? '' : backSide!,
            docNumber: documentNumberController.text,
            FrontPath: ''.toString(),
            BackPath: ''.toString(),
            attachmentTypeId: documentId.toString(),
            documentType: ''.toString(),
            userId: _accountProvider.userDetails!.userDetails.id.toString(),
            createdBy: ''.toString(),
            expiryDate: expiryController.text,
            issuingAuthority: issuingAuthorityController.text,
            issuingCountryId: issuingId.toString(),
            isIdentityId: true,
            FrontFileName: frontSideController.text,
            BackFileName: backSideController.text,
            isRequired: true,
            isActive: true,
            remarks: ''.toString(),
          ),
          Attachment(
            id: ''.toString(),
            docNumber: ''.toString(),
            // attachmentTypeId: documentTypeController.text,
            attachmentTypeId: Encryption.encryptObject(jsonEncode(6)),
            documentType: ''.toString(),
            userId: _accountProvider.userDetails!.userDetails.id.toString(),
            createdBy: ''.toString(),
            expiryDate: expiryController.text,
            issuingAuthority: issuingAuthorityController.text,
            issuingCountryId: issuingId.toString(),
            isIdentityId: true,
            isRequired: true,
            isActive: true,
            remarks: ''.toString(),
            FrontFileName: utilityController.text.toString(),
            BackFile: ''.toString(),
            BackPath: ''.toString(),
            FrontPath: ''.toString(),
            FrontFile: utilityBill.toString(),
            BackFileName: ''.toString(),
          ),
        ]);

    // Logger().i(params.toJson());
    print(params.toJson());
    var updateEither = await setProfileDetailsUsecase(params);

    if (updateEither.isLeft()) {
      saveNotifier.value = false;
      handleError(updateEither);
      print('aftab');
      // personalFormKey.currentState!.validate();
      // addressFormKey.currentState!.validate();
      // documentFormKey.currentState!.validate();

    } else if (updateEither.isRight()) {
      updateEither.foldRight(null, (response, previous) {
        updateEither.foldRight(null, (response, _) {
          onErrorMessage?.call(OnErrorMessageModel(message: 'Done', backgroundColor: Colors.green));
        });
        goBackToReceiverInfo();
        saveNotifier.value = false;
      });
      saveNotifier.value = false;
    }
  }

  // Methods
  void onPageChange(int index) {
    if (index > 0 && index <= 1) {
      validateFirstPage();
    } else if (index > 1 && index <= 2) {
      validateSecondPage();
    }
  }

  goBackToReceiverInfo() {
    PaymentWrapperViewModel provier = sl();
    provier.buttonTap(1);
  }

  void validateFirstPage() {
    isPersonalPageChange = true;
    if (!personalFormKey.currentState!.validate()) {
      pageController.animateToPage(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutCubic);
    }
  }

  void validateSecondPage() {
    isAddressPageChange = true;
    if (!addressFormKey.currentState!.validate()) {
      pageController.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutCubic);
    }
  }

  void onMiddleCheckboxClicked(bool? value) {
    middleNameNotifier.value = value ?? false;
  }
  void onLastCheckboxClicked(bool? value) {
    lastNameNotifier.value = value ?? false;
  }

  void onFirstNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(middleNameFocusNode);
  }

  void onMiddleNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(lastNameFocusNode);
  }

  void onLastNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(cobFocusNode);
  }

  void onCodSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(occupationFocusNode);
  }

  void onOccupationSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(nationalityFocusNode);
  }

  void onNationalitySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onContactSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(dobFocusNode);
  }

  void onDobSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onAddressSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(postalFocusNode);
  }

  void onPostalSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(cityFocusNode);
  }

  void onCitySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(provinceFocusNode);
  }

  void onProvinceSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onDocumentTypeSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(documentNumberFocusNode);
  }

  void onDocumentNumberSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(frontSideFocusNode);
  }

  void onFrontSideSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(backSideFocusNode);
  }

  void onBackSideSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(expiryFocusNode);
  }

  void onExpiryDateSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(issuingAuthorityFocusNode);
  }

  void onIssuingAuthoritySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(issuingCountryFocusNode);
  }

  void onIssuingCountrySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(utilityFocusNode);
  }

  void onUtilitySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String? validateFirstName(String? value) {
    if (!isPersonalPageChange) {
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
    isPersonalPageChange = false;
    if (isFirstNameError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validateMiddleName(String? value) {
    if (!isPersonalPageChange) {
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
    isPersonalPageChange = false;
    if (isMiddleNameError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validateLastName(String? value) {
    if (!isPersonalPageChange) {
      return null;
    }
    isMiddleNameError = true;
    var result = FormValidators.validateName(value?.trim());
    if (result == null) {
      isMiddleNameError = false;
    }
    return result;
  }

  void onLastNameChange(String value) {
    isPersonalPageChange = false;
    if (isMiddleNameError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validateCob(String? value) {
    if (!isPersonalPageChange) {
      return null;
    }
    isCobError = true;
    var result = FormValidators.validateCountry(value?.trim());
    if (result == null) {
      isCobError = false;
    }
    return result;
  }

  void onCobChange(String value) {
    isPersonalPageChange = false;
    if (isCobError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validateOccupation(String? value) {
    if (!isPersonalPageChange) {
      return null;
    }
    isOccupationError = true;
    var result = FormValidators.validateOccupation(value?.trim());
    if (result == null) {
      isOccupationError = false;
    }
    return result;
  }

  void onOccupationChange(String value) {
    isPersonalPageChange = false;
    if (isOccupationError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validateNationality(String? value) {
    if (!isPersonalPageChange) {
      return null;
    }
    isCobError = true;
    var result = FormValidators.validateCountry(value?.trim());
    if (result == null) {
      isCobError = false;
    }
    return result;
  }

  void onNationalityChange(String value) {
    isPersonalPageChange = false;
    if (isCobError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validatePhone(String? value) {
    if (!isPersonalPageChange) {
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
    isPersonalPageChange = false;
    if (isPhoneError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validateDob(String? value) {
    if (!isPersonalPageChange) {
      return null;
    }
    isDobError = true;
    var result = FormValidators.validateDOB(value?.trim());
    if (result == null) {
      isDobError = false;
    }
    return result;
  }

  void onDobChange(String value) {
    isPersonalPageChange = false;
    if (isDobError) {
      personalFormKey.currentState!.validate();
    }
  }

  String? validateAddress(String? value) {
    if (!isAddressPageChange) {
      return null;
    }
    isAddressError = true;
    var result = FormValidators.validateAddress(value?.trim());
    if (result == null) {
      isAddressError = false;
    }
    return result;
  }

  void onAddressChange(String value) {
    isAddressPageChange = false;
    if (isAddressError) {
      addressFormKey.currentState!.validate();
    }
  }

  String? validatePostalCode(String? value) {
    if (!isAddressPageChange) {
      return null;
    }
    isPostalCodeError = true;
    var result = FormValidators.validatePostalCode(value?.trim());
    if (result == null) {
      isPostalCodeError = false;
    }
    return result;
  }

  void onPostalCodeChange(String value) {
    isAddressPageChange = false;
    if (isPostalCodeError) {
      addressFormKey.currentState!.validate();
    }
  }

  String? validateCity(String? value) {
    if (!isAddressPageChange) {
      return null;
    }
    isCityError = true;
    var result = FormValidators.validateCity(value?.trim());
    if (result == null) {
      isCityError = false;
    }
    return result;
  }

  void onCityChange(String value) {
    isAddressPageChange = false;
    if (isCityError) {
      addressFormKey.currentState!.validate();
    }
  }

  String? validateProvince(String? value) {
    if (!isAddressPageChange) {
      return null;
    }
    isProvinceError = true;
    var result = FormValidators.validateProvince(value?.trim());
    if (result == null) {
      isProvinceError = false;
    }
    return result;
  }

  void onProvinceChange(String value) {
    isAddressPageChange = false;
    if (isProvinceError) {
      addressFormKey.currentState!.validate();
    }
  }

  String? validateDocumentType(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isDocumentTypeError = true;
    var result = FormValidators.validateDocumentType(value?.trim());
    if (result == null) {
      isDocumentTypeError = false;
    }
    return result;
  }

  void onDocumentTypeChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isDocumentTypeError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateDocumentNumber(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isDocumentNumberError = true;
    var result = FormValidators.validateDocumentRemarks(value?.trim());
    if (result == null) {
      isDocumentNumberError = false;
    }
    return result;
  }

  void onDocumentNumberChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isDocumentNumberError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateFrontSide(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isFrontSideError = true;
    var result = FormValidators.validateFrontSide(value?.trim());
    if (result == null) {
      isFrontSideError = false;
    }
    return result;
  }

  void onFrontSideChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isFrontSideError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateBackSide(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isBackSideError = true;
    var result = FormValidators.validateBackSide(value?.trim());
    if (result == null) {
      isBackSideError = false;
    }
    return result;
  }

  void onBackSideChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isBackSideError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateExpiryDate(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isExpiryDateError = true;
    var result = FormValidators.validateExpiryDate(value?.trim());
    if (result == null) {
      isExpiryDateError = false;
    }
    return result;
  }

  void onExpiryDateChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isExpiryDateError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateIssuingAuthority(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isIssuingAuthorityError = true;
    var result = FormValidators.validateIssuingAuthority(value?.trim());
    if (result == null) {
      isIssuingAuthorityError = false;
    }
    return result;
  }

  void onIssuingAuthorityChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isIssuingAuthorityError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateIssuingCountry(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isIssuingCountryError = true;
    var result = FormValidators.validateIssuingCountry(value?.trim());
    if (result == null) {
      isIssuingCountryError = false;
    }
    return result;
  }

  void onIssuingCountryChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isIssuingCountryError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateUtility(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isUtilityError = true;
    var result = FormValidators.validateUtility(value?.trim());
    if (result == null) {
      isUtilityError = false;
    }
    return result;
  }

  void onUtilityChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isUtilityError) {
      documentFormKey.currentState!.validate();
    }
  }

  XFile? selectedFile;
  ValueNotifier<File?> docsImgFile = ValueNotifier(null);
  Future<void> pickFiles(BuildContext context, AttachmentType type, String source) async {
    selectedFile = null;
    try {
      switch (source) {
        case 'camera':
          selectedFile = (await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50));
          break;
        case 'gallery':
          selectedFile = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50));
          break;
      }
      if (selectedFile != null) {
        docsImgFile.value = File(selectedFile!.path);
        String? base64 = encodeToBase64((docsImgFile.value));
        if (base64 != null) {
          switch (type) {
            case AttachmentType.frontSide:
              frontSide = base64;
              frontSideController.text = docsImgFile.value!.path.split('/').last;
              break;
            case AttachmentType.backSide:
              backSide = base64;
              backSideController.text = docsImgFile.value!.path.split('/').last;
              break;
            case AttachmentType.utilityBill:
              utilityBill = base64;
              utilityController.text = docsImgFile.value!.path.split('/').last;
              break;
          }
        }
      }
    } on PlatformException catch (e) {
      onErrorMessage?.call(OnErrorMessageModel(message: e.message.toString()));
    } catch (e) {
      onErrorMessage?.call(OnErrorMessageModel(message: e.toString()));
    }
  }

  Future<void> personalDetailsImageSelector(context, AttachmentType attachmentType) async {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: 150,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: Colors.orange,
                    ),
                    title: const Text('Camera'),
                    onTap: () {
                      pickFiles(context, attachmentType, 'camera');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.orange,
                      ),
                      title: const Text('Pick From Gallery'),
                      onTap: () {
                        pickFiles(context, attachmentType, 'gallery');
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  String? encodeToBase64(File? file) {
    if (file != null) {
      List<int> imageBytes = file.readAsBytesSync();
      return base64Encode(imageBytes);
    }
    return null;
  }

  File decodeToImage(String base64, String fileName, String extension) {
    final decodedBytes = base64Decode(base64);
    var file = File(fileName + extension);
    file.writeAsBytesSync(decodedBytes);
    return file;
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

// Page Moves
}
