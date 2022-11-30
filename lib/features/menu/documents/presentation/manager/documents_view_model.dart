import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uremit/features/menu/update_profile/usecases/get_countries_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/constants/enums/page_state_enum.dart';
import 'package:uremit/utils/router/models/page_action.dart';
import 'package:uremit/utils/router/models/page_config.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../services/models/no_params.dart';
import '../../../../../utils/constants/enums/attachment_type.dart';
import '../../../../../utils/globals/app_globals.dart' as data;
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../../../files/previous_files/presentation/manager/previous_files_view_model.dart';
import '../../../../files/required_files/presentation/manager/required_file_view_model.dart';
import '../../../update_profile/models/doc_type_request_model.dart';
import '../../../update_profile/models/doc_type_response_model.dart';
import '../../../update_profile/models/get_countries_response_model.dart';
import '../../../update_profile/usecases/doc_type_usecase.dart';
import '../../models/doc_requied_request_model.dart';
import '../../usecases/required_document_usecase.dart';

class DocumentsViewModel extends ChangeNotifier {
  DocumentsViewModel({required this.docTypeUsecase, required this.getCountriesUsecase, required this.requiredDocumentUsecase});
  // Usecases

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isDocsLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isCountryLoadingNotifier = ValueNotifier(false);
  bool isSaveButtonPressed = false;

  bool isDocumentTypeError = false;
  bool isDocumentRemarksError = false;
  bool isFrontSideError = false;
  bool isBackSideError = false;
  bool isIssuingCountryError = false;
  bool isIssuingAuthorityError = false;
  bool isExpiryDateError = false;
  ValueNotifier<DateTime?> updateExpiryDate = ValueNotifier(null);
  DocTypeResponseModel? docTypeList;
  DocTypeBody? docType;
  DocTypeUsecase docTypeUsecase;
  GetCountriesResponseModel? countriesList;
  CountriesBody? issuingCountry;
  GetCountriesUsecase getCountriesUsecase;
  RequiredDocumentUsecase requiredDocumentUsecase;

  bool isDocumentPageButtonPressed = false;

  // Properties
  final GlobalKey<FormState> documentFormKey = GlobalKey<FormState>();

  final String documentTypeLabelText = 'Document Type';
  final String documentTypeHintText = 'Select Document Type';
  final TextEditingController documentTypeController = TextEditingController();
  String attachmentTypeId = '';
  final FocusNode documentTypeFocusNode = FocusNode();

  final String documentRemarksLabelText = 'Document Remarks';
  final String documentRemarksHintText = 'Enter Document Remarks';
  final TextEditingController documentRemarksController = TextEditingController();
  final FocusNode documentRemarksFocusNode = FocusNode();

  final String frontSideLabelText = 'Front Side';
  final String frontSideHintText = 'Upload Front Side';
  final TextEditingController frontSideController = TextEditingController();
  final FocusNode frontSideFocusNode = FocusNode();

  DateTime expiryDateTime = DateTime.now();
  final String expiryLabelText = 'Expiry Date';
  final String expiryHintText = 'Select Expiry Date';
  final TextEditingController expiryController = TextEditingController();
  final FocusNode expiryFocusNode = FocusNode();

  final String backSideLabelText = 'Back Side';
  final String backSideHintText = 'Upload Front Side';
  final TextEditingController backSideController = TextEditingController();
  final FocusNode backSideFocusNode = FocusNode();

  final String issuingAuthorityLabelText = 'Issuing Authority';
  final String issuingAuthorityHintText = 'Enter Issuing Authority';
  final TextEditingController issuingAuthorityController = TextEditingController();
  final FocusNode issuingAuthorityFocusNode = FocusNode();

  final String issuingCountryLabelText = 'Issuing Country';
  final String issuingCountryHintText = 'Select Issuing Country';
  final TextEditingController issuingCountryController = TextEditingController();
  String issuingId = '';
  final FocusNode issuingCountryFocusNode = FocusNode();

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> documentRequired(BuildContext context) async {
    isDocsLoadingNotifier.value = true;

    var params = DocumentRequiredRequestModel(
        id: data.requiredDocId,
        frontFileName: frontSideController.text,
        backFileName: backSideController.text,
        docNumber: documentRemarksController.text,
        frontPath: ''.toString(),
        backPath: ''.toString(),
        attachmentTypeId: data.requiredDocAttachmentId,
        documentType: documentTypeController.text,
        userId: _accountProvider.userDetails!.userDetails.id.toString(),
        createdBy: ''.toString(),
        expiryDate: expiryController.text,
        issuingAuthority: issuingAuthorityController.text,
        issuingCountryId: issuingId,
        isIdentityId: true,
        frontFile: frontSide.toString(),
        backFile: backSide.toString(),
        isRequired: true,
        isActive: true,
        remarks: ''.toString());

    // Logger().i(params.toJson());
    print(params.toJson());
    var docRequiredEither = await requiredDocumentUsecase(params);

    if (docRequiredEither.isLeft()) {
      isDocsLoadingNotifier.value = false;
      handleError(docRequiredEither);
    } else if (docRequiredEither.isRight()) {
      docRequiredEither.foldRight(null, (response, previous) {
        docRequiredEither.foldRight(null, (response, _) {
          isDocsLoadingNotifier.value = false;
          onErrorMessage?.call(OnErrorMessageModel(message: 'Successful', backgroundColor: Colors.green));
          clearFields();
          RequiredFilesViewModel reqFileViewModal = sl();
          PreviousFilesViewModel previousFilesViewModel = sl();
          reqFileViewModal.isLoadingNotifier.value = true;
          reqFileViewModal.getRequiredFiles(recall: true);
          previousFilesViewModel.isLoadingNotifier.value = true;
          previousFilesViewModel.getPreviousFiles(true);
          clearFields();
        });
        isDocsLoadingNotifier.value = false;
      });
      isDocsLoadingNotifier.value = false;
    }
  }

  clearFields() {
    documentTypeController.text = '';
    documentRemarksController.text = '';
    expiryController.text = '';
    issuingAuthorityController.text = '';
    frontSideController.text = '';
    backSideController.text = '';
    issuingCountryController.text = '';
    issuingId = '';
    frontSide = '';
    backSide = '';
  }

  // Methods
  void onDocumentTypeSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(documentRemarksFocusNode);
  }

  void onDocumentNumberSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(frontSideFocusNode);
  }

  void onFrontSideSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(backSideFocusNode);
  }

  void onBackSideSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onIssuingAuthoritySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(issuingCountryFocusNode);
  }

  void onIssuingCountrySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus();
  }

  void onExpiryDateSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(expiryFocusNode);
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

  void onDocumentTypeChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isDocumentTypeError) {
      documentFormKey.currentState!.validate();
    }
  }

  String? validateDocumentRemarks(String? value) {
    if (!isDocumentPageButtonPressed) {
      return null;
    }
    isDocumentRemarksError = true;
    var result = FormValidators.validateDocumentRemarks(value?.trim());
    if (result == null) {
      isDocumentRemarksError = false;
    }
    return result;
  }

  void onDocumentRemarksChange(String value) {
    isDocumentPageButtonPressed = false;
    if (isDocumentRemarksError) {
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

  String? frontSide;
  String? backSide;
  String? utilityBill;
  List<PlatformFile> paths = [];

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

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

  // Page Moves
  void moveToFilesWrapperPage() {
    appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.filesWrapperPageConfig);
  }
}
