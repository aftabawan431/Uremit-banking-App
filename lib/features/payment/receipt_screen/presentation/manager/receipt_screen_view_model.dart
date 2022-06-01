import 'dart:developer';

import 'package:uremit/features/payment/receipt_screen/modal/paid_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/poly_response_modal.dart';
import 'package:uremit/services/models/error_response_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/getPaymentMethodResponseModal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_transfer_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/transection_three_sixty_respose_modal.dart';
import 'package:uremit/features/payment/receipt_screen/usecases/getPaymentMethodsResponseUsecase.dart';
import 'package:uremit/features/payment/receipt_screen/usecases/insert_payment_usecase.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
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

class ReceiptScreenViewModel extends ChangeNotifier {

  // Usecases
  GetPaymentMethodsReponseUsecase getPaymentMethodsReponseUsecase;
  InsertPaymentUsecase insertPaymentUsecase;
  ReceiptScreenViewModel(
      {required this.getPaymentMethodsReponseUsecase,
      required this.insertPaymentUsecase});

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<int> totalFee = ValueNotifier(0);
  ValueNotifier<bool> isPaymentMethodsLoading = ValueNotifier(false);
  ValueNotifier<bool> insertPaymentLoading = ValueNotifier(false);
  ValueNotifier<bool> isSchedule = ValueNotifier(false);

  bool isManualBankGatway=false;

  ValueNotifier<List<PaymentMethodBody>> getPaymentMethodsBodyList =
      ValueNotifier([]);
  ValueNotifier<PaymentMethodBody?> selectedPaymentMethod = ValueNotifier(null);

  // Properties
  InsertPaymentTransferResponseModal? insertPaymentTransferResponseModal;
  PayIdBankResponseModal? payIdResponseModal;
  ManualBankResponseModal? manualBankResponseModal;
  // Getters
  AppState appState = GetIt.I.get<AppState>();

  // Usecase Calls
  Future<void> getPaymentMethods() async {
    if (getPaymentMethodsBodyList.value.isNotEmpty) {

      selectedPaymentMethod.value = getPaymentMethodsBodyList.value.first;
      return;
    }
    isPaymentMethodsLoading.value = true;
    var getPaymentMethodsEither =
        await getPaymentMethodsReponseUsecase.call(NoParams());
    if (getPaymentMethodsEither.isLeft()) {
      handleError(getPaymentMethodsEither);
      isPaymentMethodsLoading.value = false;
    } else if (getPaymentMethodsEither.isRight()) {
      getPaymentMethodsEither.foldRight(null, (response, _) {
        getPaymentMethodsBodyList.value = response.paymentMethodBodyList;
        if (getPaymentMethodsBodyList.value.isNotEmpty) {
          selectedPaymentMethod.value = getPaymentMethodsBodyList.value.first;
        }
      });
      isPaymentMethodsLoading.value = false;
    }
  }
 bool isPaymentThreeSixty(){
    return selectedPaymentMethod.value!.id==5||selectedPaymentMethod.value!.id==6;

  }
  int get adminFee=>double.parse(selectedPaymentMethod.value!.adminFee).toInt();
  int get gatewayFee=>double.parse(selectedPaymentMethod.value!.charges).toInt();

 void  setTotalFee(){

    PaymentDetailsViewModel paymentDetailsViewModel=GetIt.I.get<PaymentDetailsViewModel>();
    int payoutPartnerFee=paymentDetailsViewModel.receiverPayoutPartner.value!=null?paymentDetailsViewModel.receiverPayoutPartner.value!.fee:0;
    totalFee.value=adminFee+gatewayFee+payoutPartnerFee;



  }
  //
  Future<void> insertPayment() async {
    if (getPaymentMethodsBodyList.value.isEmpty) {
      return;
    }

    PaymentDetailsViewModel paymentDetailsViewModel=GetIt.I.get<PaymentDetailsViewModel>();
    ReceiverViewModel receiverViewModel=GetIt.I.get<ReceiverViewModel>();
    HomeViewModel homeViewModel=GetIt.I.get<HomeViewModel>();
    AccountProvider accountProvider=GetIt.I.get<AccountProvider>();
    CardsViewModel cardsViewModel=GetIt.I.get<CardsViewModel>();
    // int gatewayFee=double.parse(selectedPaymentMethod.value!.charges).toInt();
    int payoutPartnerFee=paymentDetailsViewModel.receiverPayoutPartner.value!=null?paymentDetailsViewModel.receiverPayoutPartner.value!.fee:0;
    int totalFee=adminFee+gatewayFee;
    if(!paymentDetailsViewModel.isAccountDeposit.value){
      totalFee=totalFee+payoutPartnerFee;
    }
    final params = InsertPaymentTransferRequestModel(
        txn: '',
        paymentGatewayId: Encryption.encryptObject(
            selectedPaymentMethod.value!.id.toString()),
        payoutMethodId: paymentDetailsViewModel.receiverPayoutMethod.value!.id,
        sendingAmount: int.parse(paymentDetailsViewModel.sendMoneyController.text),
        payoutPartnerId: paymentDetailsViewModel.receiverPayoutMethod.value!.name=='Account Deposit'?'':paymentDetailsViewModel.receiverPayoutPartner.value!.id ,
        sendingAmountWithFee: int.parse(paymentDetailsViewModel.sendMoneyController.text)+totalFee,
        receivingAmount: int.parse(paymentDetailsViewModel.sendMoneyController.text)*paymentDetailsViewModel.getExchageRate().toInt(),
        receivingCountryCurrencyId:Encryption.encryptObject(79.toString()),
        discount: 0,
        status: 0,
        receiverId: receiverViewModel.selectedReceiver.value!.receiverId,
        receiverBankAccountId: paymentDetailsViewModel.receiverPayoutMethod.value!.name!='Account Deposit'?'':receiverViewModel.selectedReceiverBank.value!.id,
        partnerTxn: '',
        isIBFT: paymentDetailsViewModel.receiverPayoutMethod.value!.name=='Account Deposit',
        ip: accountProvider.ip,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        userId: Encryption.encryptObject(homeViewModel.profileHeader!.profileHeaderBody[0].userID),
        companyId: 'gfju6q24Ox9MmN8MuhUoVw==',
        senderCardId: cardsViewModel.selectedCard!=null?cardsViewModel.selectedCard!.id:'',
        arrivingTime: double.parse(selectedPaymentMethod.value!.arrivalTime).toInt(),
        promoCode: '',
        receiverCountryId: paymentDetailsViewModel.receiverCountry!.id,
        isScheduled: isSchedule.value,
        exchangeRate: paymentDetailsViewModel.getExchageRate().toInt(),
        reason: paymentDetailsViewModel.reasonController.text,
        administrativeFee: adminFee,
        payoutPartnerFee: payoutPartnerFee,
        payoutMethodFee: paymentDetailsViewModel.receiverPayoutMethod.value!.fee,
        paymentGatewayFee: gatewayFee,
        totalFee: totalFee);
    log(params.toJson().toString());

    insertPaymentLoading.value = true;
    var insertPaymentEither = await insertPaymentUsecase.call(params);
    if (insertPaymentEither.isLeft()) {
      handleError(insertPaymentEither);
      insertPaymentLoading.value = false;
    } else if (insertPaymentEither.isRight()) {
      insertPaymentEither.foldRight(null, (response, _) {
        insertPaymentTransferResponseModal = response;
        if(response.payIdBankResponseModal!=null){
          _handlePayId(response.payIdBankResponseModal!);
        }else if(response.polyResponseModal!=null){
          _handlePoly(response.polyResponseModal!);
        }else if(response.threeSixtyResponseModal!=null){
          _handleThreeSixty(response.threeSixtyResponseModal!);
        }else if(response.manualBankResponseModal!=null){
          _handleManualBankTransfer(response.manualBankResponseModal!);
        }

      });
      insertPaymentLoading.value = false;
    }
  }

  // Future<void> insertPayment() async {}
  // Methods
  _handleThreeSixty(TransectionThreeSixtyResponseModal modal)async{
    if(modal.Body.checkout.redirect_url.isEmpty){
      return onErrorMessage?.call(OnErrorMessageModel(message: 'Error in redirect URL'));
    }
    if (!await launchUrl(Uri.parse(modal.Body.checkout.redirect_url))) throw 'Could not launch ';
    AppState appState = sl();
    appState.currentAction = PageAction(
        state: PageState.replace, page: PageConfigs.summaryDetailsScreenPageConfig);
  }
  _handlePoly(PolyResponseModal modal)async{
    if(modal.Body.navigateURL.isEmpty){
      return onErrorMessage?.call(OnErrorMessageModel(message: 'Error in redirect URL'));
    }
    if (!await launchUrl(Uri.parse(modal.Body.navigateURL))) throw 'Could not launch ';
    AppState appState = sl();
    appState.currentAction = PageAction(
        state: PageState.replace, page: PageConfigs.summaryDetailsScreenPageConfig);
}
  _handlePayId(PayIdBankResponseModal modal)async{
    isManualBankGatway=false;
    payIdResponseModal=modal;
    if(selectedPaymentMethod.value!.id==8){
      goToPayIdOrManualBank();
    }

  }
  _handleManualBankTransfer(ManualBankResponseModal modal)async{
    manualBankResponseModal=modal;
    isManualBankGatway=true;

    if(selectedPaymentMethod.value!.id==9){
      goToPayIdOrManualBank();
    }

  }
  goToPayIdOrManualBank() {
    AppState appState = sl();
    appState.currentAction = PageAction(
        state: PageState.replace, page: PageConfigs.payIdInfoPageConfig);
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
