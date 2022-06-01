import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:uremit/features/receivers/models/delete_receiver_bank_request_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_request_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_response_model.dart';
import 'package:uremit/features/receivers/models/receiver_list_request_model.dart';
import 'package:uremit/features/receivers/models/receiver_list_response_model.dart';
import 'package:uremit/features/receivers/models/update_receiver_nickname_request_model.dart';
import 'package:uremit/features/receivers/usecases/delete_receiver_bank_usecase.dart';
import 'package:uremit/features/receivers/usecases/delete_receiver_usecase.dart';
import 'package:uremit/features/receivers/usecases/get_bank_list_usecase.dart';
import 'package:uremit/features/receivers/usecases/receiver_list_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../app/globals.dart';
import '../../../../app/providers/account_provider.dart';
import '../../../../app/widgets/customs/tabview/custom_tab_view.dart';
import '../../../../services/error/failure.dart';
import '../../../../utils/router/app_state.dart';
import '../../../../utils/validators/form_validator.dart';
import '../../models/get_bank_list_request_model.dart';
import '../../models/get_bank_list_response_model.dart';
import '../../usecases/update_receiver_nickname_usecase.dart';

class ReceiverViewModel extends ChangeNotifier {
  ReceiverViewModel(this.receiverListUsecase, this.deleteReceiverUsecase,this.getBankListUsecase,this.deleteReceiverBankListUsecase,this.updateReceiverNicknameUsecase);
  final GlobalKey<CustomTabViewState> bottomNavigationKey = GlobalKey();
  final GlobalKey<FormState> addReceiverBankFormKey=GlobalKey();
  // Usecases
  ReceiverListUsecase receiverListUsecase;

  DeleteReceiverUsecase deleteReceiverUsecase;
  DeleteReceiverBankListUsecase deleteReceiverBankListUsecase;
  DeleteReceiverResponseModelBody? deleteReceiverResponseModelBody;
  GetBankListResponseModel? getBanks;
  GetBankListResponseModelBody? getBankListResponseModelBody;
  GetBankListUsecase getBankListUsecase;
  UpdateReceiverNicknameUsecase updateReceiverNicknameUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isReceiverDeleteNotifier = ValueNotifier(false);
  ValueNotifier<bool> isBanksListLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isExpansionOpenNotifier = ValueNotifier(false);
  ValueNotifier<List<ReceiverListBody>> receiverListNotifier = ValueNotifier([]);
  ValueNotifier<List<ReceiverListBody>> receiverListNotifierHeader = ValueNotifier([]);
  ValueNotifier<bool> status = ValueNotifier(false);
  ValueNotifier<ReceiverListBody?> selectedReceiver = ValueNotifier(null);

  ValueNotifier<ReceiverBank?> selectedReceiverBank = ValueNotifier(null);

  GlobalKey<FormState> editNickNameKey=GlobalKey();

  // Properties
  ReceiverListResponseModel? receiverList;
  bool isEmailError = false;
  bool isReceiverInfoPageChange = false;
  final FocusNode bankFocusNode = FocusNode();
  final String bankLabelText = 'Bank';
  final String bankHintText = 'Enter Bank';
  String? bankId='';
  final TextEditingController bankController = TextEditingController();

  RadioGroupController accountTypeController = RadioGroupController();
  final List<String> accountTypeValues = ['IBAN', 'Account Number'];

  final FocusNode accountNumberFocusNode = FocusNode();
  final String accountNumberLabelText = 'Account Number';
  final String accountNumberHintText = 'Enter Account Number';
  final TextEditingController accountNumberController = TextEditingController();


  String countryId='';

  final FocusNode accountHolderNameFocusNode = FocusNode();
  final String accountHolderNameLabelText = 'Account Holder Name';
  final String accountHolderNameHintText = 'Account Holder Name';
  final TextEditingController accountHolderNameController = TextEditingController();
  final TextEditingController editNickNameController = TextEditingController();
  bool isNickNameError=false;



  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getReceiverList({bool recall=false}) async {

    if(receiverList !=null){
      if(recall==false){
        return;
      }
    }
    isLoadingNotifier.value = true;


    var receiverListEither = await receiverListUsecase(ReceiverListRequestModel(id: _accountProvider.userDetails!.userDetails.id));

    if (receiverListEither.isLeft()) {
      handleError(receiverListEither);
      isLoadingNotifier.value = false;
    } else if (receiverListEither.isRight()) {
      receiverListEither.foldRight(null, (response, _) {
        receiverList = response;
        receiverList!.receiverListBody.sort((a, b) => a.nickName.toLowerCase().compareTo(b.nickName.toLowerCase()));
        receiverListNotifier.value = receiverList?.receiverListBody ?? [];
        receiverListNotifierHeader.value = receiverList?.receiverListBody ?? [];
      });

      isLoadingNotifier.value = false;
    }
  }

  emptyReceiverLists(){
    receiverList=null;
    receiverListNotifier.value=[];
    receiverListNotifierHeader.value=[];
    selectedReceiverBank.value=null;
  }
  Future<void> deleteReceiver(BuildContext context,String receiverId) async {
    isReceiverDeleteNotifier.value = true;

    var params = DeleteReceiverRequestModel(
      receiverID: receiverId,
    );
    var deleteReceiverEither = await deleteReceiverUsecase.call(params);

    if (deleteReceiverEither.isLeft()) {
      print('lol');
      handleError(deleteReceiverEither);
      isReceiverDeleteNotifier.value = false;
    } else if (deleteReceiverEither.isRight()) {
      Navigator.of(context).pop();
      getReceiverList(recall: true);
      onErrorMessage?.call(OnErrorMessageModel(message: 'Receiver delted',backgroundColor: Colors.green),);
      deleteReceiverEither.foldRight(null, (response, _) {
        // onErrorMessage?.call(OnErrorMessageModel(message: response.deleteReceiverResponseModelBody., backgroundColor: Colors.green));
      });
      isReceiverDeleteNotifier.value = false;
    }
  }

  Future<void> updateReceiverNickName(BuildContext context,String receiverId,String nickname,ValueNotifier<bool> loading) async {
    loading.value=true;
    var params = UpdateReceiverNicknameRequestModel(
      receiverID: receiverId,
      nickName: nickname
    );
    Logger().i(params.toJson());
    var updateNicknameEither = await updateReceiverNicknameUsecase.call(params);

    if (updateNicknameEither.isLeft()) {
      print('lol');
      Logger().i(updateNicknameEither);
      handleError(updateNicknameEither);

    } else if (updateNicknameEither.isRight()) {
      // Navigator.of(context).pop();

      onErrorMessage?.call(OnErrorMessageModel(message: 'Receiver Updated',backgroundColor: Colors.green),);
      // loading.value=false;
      getReceiverList(recall: true);
      updateNicknameEither.foldRight(null, (response, _) {
        // onErrorMessage?.call(OnErrorMessageModel(message: response.deleteReceiverResponseModelBody., backgroundColor: Colors.green));
      });
    }
  }
  Future<void> deleteReceiverBank(BuildContext context,String bankId) async {
    isReceiverDeleteNotifier.value = true;

    var params = DeleteReceiverBankListRequestModel(
       id: bankId,
    );
    var deleteReceiverEither = await deleteReceiverBankListUsecase.call(params);

    if (deleteReceiverEither.isLeft()) {
      print('lol');
      handleError(deleteReceiverEither);
      isReceiverDeleteNotifier.value = false;
    } else if (deleteReceiverEither.isRight()) {
      Navigator.of(context).pop();
      getReceiverList(recall: true);
      onErrorMessage?.call(OnErrorMessageModel(message: 'Receiver delted',backgroundColor: Colors.green),);
      deleteReceiverEither.foldRight(null, (response, _) {
        // onErrorMessage?.call(OnErrorMessageModel(message: response.deleteReceiverResponseModelBody., backgroundColor: Colors.green));
      });
      isReceiverDeleteNotifier.value = false;
    }
  }

  // Methods
  void onExpansionChanged(bool value) {
    isExpansionOpenNotifier.value = value;
  }


  String? validateNickName(String? value) {

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
      editNickNameKey.currentState!.validate();
    }
  }
  bool validateBankInfo(){
    // isB = true;

    return addReceiverBankFormKey.currentState!.validate();
  }

  String? validateAccountNumber(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }

    var result = FormValidators.validateAccountNumber(value?.trim());

    return result;
  }
  void onEmailChange(String value) {
    isReceiverInfoPageChange = false;
    if (isEmailError) {
      addReceiverBankFormKey.currentState!.validate();
    }
  }
  String? validateBank(String? value) {
    if (!isReceiverInfoPageChange) {
      return null;
    }

    var result = FormValidators.validateBank(value?.trim());

    return result;
  }

  void onBankSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(accountNumberFocusNode);
  }

  void filterSearchResults(String query) {
    List<ReceiverListBody> tempList = [];
    tempList.addAll(receiverList?.receiverListBody ?? []);
    if (query.isNotEmpty) {
      List<ReceiverListBody> dummyList = [];
      for (var receiver in tempList) {
        if (receiver.nickName.toLowerCase().contains(query.toLowerCase())) {
          dummyList.add(receiver);
        }
      }
      receiverListNotifier.value = dummyList;
    } else {
      receiverListNotifier.value = receiverList?.receiverListBody ?? [];
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

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

  // Page Moves
}
