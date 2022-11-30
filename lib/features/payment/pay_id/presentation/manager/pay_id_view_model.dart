import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/features/dashboard/presentation/manager/dashboard_view_model.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_proof_response_modal.dart';
import 'package:uremit/features/payment/pay_id/use_cases/insert_payment_proof_usecase.dart';
import 'package:uremit/features/payment/payment_details/models/update_transaction_status_request_model.dart';
import 'package:uremit/features/payment/payment_details/models/update_transaction_status_response_model.dart';
import 'package:uremit/features/payment/payment_details/usecase/update_transaction_status_usecase.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/encryption/encryption.dart';

import '../../../../../services/error/failure.dart';
import '../../../../../utils/constants/enums/attachment_type.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';

class PayIdInfoViewModel extends ChangeNotifier {
  // Usecases
  InsertPaymentProofUsecase insertPaymentProofUsecase;
  UpdateTransactionStatusUsecase updateTransactionStatusUsecase;
  PayIdInfoViewModel(
      this.insertPaymentProofUsecase, this.updateTransactionStatusUsecase);

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isTransactionStatusLoadingNotifier = ValueNotifier(false);
  ValueNotifier<File?> selectedFile = ValueNotifier(null);
  String? selectedFileBase64;
  UpdateTransactionStatusResponseModel? updateTransactionStatusResponseModel;

  // Properties
  List<PlatformFile> paths = [];
  // Getters
  AppState appState = GetIt.I.get<AppState>();

  // Usecase Calls

  updateTransactionStatus() async {
    isTransactionStatusLoadingNotifier.value = true;
    ReceiptScreenViewModel receiptScreenViewModel = sl();
    final txnNo = receiptScreenViewModel.isManualBankGateway
        ? receiptScreenViewModel.manualBankResponseModal!.Body.txn
        : receiptScreenViewModel.payIdResponseModal!.Body.txn;
    var params = UpdateTransactionStatusRequestModel(txn: txnNo);

    var getRateListEither = await updateTransactionStatusUsecase(params);
    if (getRateListEither.isLeft()) {
      handleError(getRateListEither);
      isTransactionStatusLoadingNotifier.value = false;
    } else if (getRateListEither.isRight()) {
      getRateListEither.foldRight(null, (response, _) {
        updateTransactionStatusResponseModel = response;
        print(
            'this is the response of updateTransactionStatusResponseModel $updateTransactionStatusResponseModel');
      });
      isTransactionStatusLoadingNotifier.value = false;

      //
    }
  }

  Future<void> insertPaymentProof() async {
    ReceiptScreenViewModel receiptViewModal = sl();
    HomeViewModel homeViewModel = sl();
    bool isManualBankTransfer = receiptViewModal.isManualBankGateway;
    // checking if user has selected manual back transfer option

    var params;
    if (receiptViewModal.fromChangePaymentMethod) {
      params = InsertPaymentProofRequestModal(
          txn: receiptViewModal.updateTransaction!.txn,
          userID: Encryption.encryptObject(
              homeViewModel.profileHeader!.profileHeaderBody.first.userID),
          document: selectedFileBase64!,
          documentPath: selectedFile.value!.path,
          documentName: imageName.toString());
    } else {
      params = InsertPaymentProofRequestModal(
          txn: isManualBankTransfer
              ? receiptViewModal.manualBankResponseModal!.Body.txn
              : receiptViewModal.payIdResponseModal!.Body.txn,
          userID: Encryption.encryptObject(
              homeViewModel.profileHeader!.profileHeaderBody.first.userID),
          document: selectedFileBase64!,
          documentPath: selectedFile.value!.path,
          documentName: imageName.toString());
    }

    isLoadingNotifier.value = true;
    var insertPaymentProofEither = await insertPaymentProofUsecase.call(params);
    if (insertPaymentProofEither.isLeft()) {
      handleError(insertPaymentProofEither);
      isLoadingNotifier.value = false;
    } else if (insertPaymentProofEither.isRight()) {
      insertPaymentProofEither.foldRight(null, (response, _) {
        DashboardViewModel dashboardViewModel = sl();
        dashboardViewModel.getTransactionList();
        if (receiptViewModal.fromChangePaymentMethod) {
          AppState appState = sl();
          appState.moveToBackScreen();
        } else {
          AppState appState = sl();
          appState.currentAction = PageAction(
              state: PageState.replace,
              page: PageConfigs.summaryDetailsScreenPageConfig);
        }
      });
      isLoadingNotifier.value = false;
    }
  }

  // Methods

  Future<void> docsImageSelector(context, AttachmentType attachmentType) async {
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

  XFile? selectedDocFile;
  String? imageName;
  // ValueNotifier<File?> docsImgFile = ValueNotifier(null);
  Future<void> pickFiles(
      BuildContext context, AttachmentType type, String source) async {
    selectedDocFile = null;
    try {
      switch (source) {
        case 'camera':
          selectedDocFile = (await ImagePicker()
              .pickImage(source: ImageSource.camera, imageQuality: 50));
          break;
        case 'gallery':
          selectedDocFile = (await ImagePicker()
              .pickImage(source: ImageSource.gallery, imageQuality: 50));
          break;
      }
      if (selectedDocFile != null) {
        selectedFile.value = File(selectedDocFile!.path);
        String? base64 = encodeToBase64((selectedFile.value));
        if (base64 != null) {
          switch (type) {

            case AttachmentType.payIdDoc:
              selectedFileBase64 = base64;
              imageName =
                  selectedFile.value!.path.split('/').last.toString();

              print(imageName);
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

  // Future<void> pickFile(BuildContext context,AttachmentType type,String source) async {
  //   paths.clear();
  //   try {
  //     paths = (await FilePicker.platform.pickFiles(
  //           type: FileType.custom,
  //           allowMultiple: false,
  //           onFileLoading: (FilePickerStatus status) => print(status),
  //           allowedExtensions: ['jpg',],
  //         ))
  //             ?.files ??
  //         [];
  //     if (paths.isNotEmpty) {
  //       String? base64 = encodeToBase64(File(paths.first.path!));
  //       selectedFileBase64 = base64;
  //       selectedFile.value = File(paths.first.path!);
  //     }
  //   } on PlatformException catch (e) {
  //     onErrorMessage?.call(OnErrorMessageModel(message: e.message.toString()));
  //   } catch (e) {
  //     onErrorMessage?.call(OnErrorMessageModel(message: e.toString()));
  //   }
  // }

  File decodeToImage(String base64, String fileName, String extension) {
    final decodedBytes = base64Decode(base64);
    var file = File(fileName + extension);
    file.writeAsBytesSync(decodedBytes);
    return file;
  }

  String? encodeToBase64(File? file) {
    if (file != null) {
      List<int> imageBytes = file.readAsBytesSync();
      return base64Encode(imageBytes);
    }
    return null;
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold(
        (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
        (r) => null);
  }

// Page Moves
}
