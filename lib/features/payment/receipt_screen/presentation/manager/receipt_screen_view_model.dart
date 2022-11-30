import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';
import 'package:uremit/features/dashboard/presentation/manager/dashboard_view_model.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_Payment_Method_Response_Model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_payment_methods_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_transaction_by%20_txn_response_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_transaction_by_txn_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_transfer_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/paid_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/poly_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/transection_three_sixty_respose_modal.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/widgets/summary_details_screen_page_content.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/widgets/web_view_content.dart';
import 'package:uremit/features/payment/receipt_screen/usecases/getPaymentMethodsResponseUsecase.dart';
import 'package:uremit/features/payment/receipt_screen/usecases/insert_payment_usecase.dart';
import 'package:uremit/features/payment/receipt_screen/usecases/update_payment_usecase.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/encryption/encryption.dart';
import 'package:uremit/utils/extensions/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/account_provider.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../services/models/no_params.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';
import '../../../receiver_info/presentation/manager/receiver_info_view_model.dart';
import '../../usecases/get_transaction_by_txn_usecase.dart';

class ReceiptScreenViewModel extends ChangeNotifier {
  // Usecases
  GetPaymentMethodsReponseUsecase getPaymentMethodsReponseUsecase;
  GetTransactionByTxnUsecase getTransactionByTxnUsecase;
  InsertPaymentUsecase insertPaymentUsecase;
  UpdatePaymentUsecase updatePaymentUsecase;
  ReceiptScreenViewModel(
      {required this.getPaymentMethodsReponseUsecase,
      required this.insertPaymentUsecase,
      required this.updatePaymentUsecase,
      required this.getTransactionByTxnUsecase});

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<double> totalFee = ValueNotifier(0.0);
  ValueNotifier<bool> isPaymentMethodsLoading = ValueNotifier(false);
  ValueNotifier<bool> insertPaymentLoading = ValueNotifier(false);
  ValueNotifier<bool> isSchedule = ValueNotifier(false);
  ValueNotifier<bool> getTransactionByTxnLoading = ValueNotifier(false);
  ValueNotifier<String> transactionStatus = ValueNotifier('Requested');

  TransactionList? updateTransaction;
  bool isManualBankGateway = false;
  bool fromChangePaymentMethod = false;
  bool isRepeatTransaction = false;

  ValueNotifier<List<PaymentMethodBody>> getPaymentMethodsBodyList =
      ValueNotifier([]);
  ValueNotifier<PaymentMethodBody?> selectedPaymentMethod = ValueNotifier(null);

  // Properties
  InsertPaymentTransferResponseModal? insertPaymentTransferResponseModal;
  PayIdBankResponseModal? payIdResponseModal;
  ManualBankResponseModal? manualBankResponseModal;
  GetTransactionByTxnResponseModel? getTransactionByTxnResponseModel;

  List<Page> get pages => List.unmodifiable(_pages);

  // Getters
  AppState appState = GetIt.I.get<AppState>();

  // Usecase Calls
  final List<Page> _pages = [
    const MaterialPage(
      child: WebView(),
    ),
  ];
  static ReceiptScreenViewModel of(BuildContext context) {
    return Provider.of<ReceiptScreenViewModel>(context, listen: false);
  }

  Future<void> pushTwoPages(String value) async {
    AppState appState = sl();
    // appState.currentAction=PageAction(pages: );
    _pages.addAll(
      [
        // You can also use CustomPage instead of MaterialPage
        await MaterialPage(
          child: WebViewContent(url: value),
          key: UniqueKey(),
          name: 'OtherScreen',
        ),
        MaterialPage(
          child: const SummaryDetailsScreenPageContent(),
          key: UniqueKey(),
          name: 'OtherScreen',
        ),
      ],
    );
    notifyListeners();
  }

  Future<void> getPaymentMethods() async {
    // if (getPaymentMethodsBodyList.value.isNotEmpty) {
    //   selectedPaymentMethod.value = getPaymentMethodsBodyList.value.first;
    //
    // }

    bool isInsert = fromChangePaymentMethod || isRepeatTransaction;

    isPaymentMethodsLoading.value = true;
    PaymentDetailsViewModel paymentDetailsViewModel = sl();

    final _params = GetPaymentMethodsRequestModel(
        payoutMethodID: !isInsert
            ? paymentDetailsViewModel.receiverPayoutMethod.value!.id
            : updateTransaction!.payoutMethodId,
        payoutPartnerID: !isInsert
            ? (paymentDetailsViewModel.receiverPayoutPartner.value != null
                ? paymentDetailsViewModel.receiverPayoutPartner.value!.id
                : '')
            : updateTransaction!.payoutPartnerId,
        countryCurrencyID: !isInsert
            ? paymentDetailsViewModel.receiverCurrency.value!.id.toString()
            : updateTransaction!.receiverCountryCurrencyID);
    var getPaymentMethodsEither =
        await getPaymentMethodsReponseUsecase.call(_params);
    if (getPaymentMethodsEither.isLeft()) {
      handleError(getPaymentMethodsEither);
      isPaymentMethodsLoading.value = false;
    } else if (getPaymentMethodsEither.isRight()) {
      getPaymentMethodsEither.foldRight(null, (response, _) {
        getPaymentMethodsBodyList.value = response.paymentMethodBodyList;
        print('huhu ${getPaymentMethodsBodyList.value}');
        if (getPaymentMethodsBodyList.value.isNotEmpty) {
          selectedPaymentMethod.value = getPaymentMethodsBodyList.value.first;
        }
      });
      isPaymentMethodsLoading.value = false;
    }
  }

  Future<void> getTransactionByTxn(String txn) async {
    getTransactionByTxnLoading.value = true;

    final _params = GetTransactionByTxnRequestModel(txn: txn);

    var getPaymentMethodsEither =
        await getTransactionByTxnUsecase.call(_params);
    if (getPaymentMethodsEither.isLeft()) {
      handleError(getPaymentMethodsEither);
      getTransactionByTxnLoading.value = false;
    } else if (getPaymentMethodsEither.isRight()) {
      getPaymentMethodsEither.foldRight(null, (response, _) {
        getTransactionByTxnResponseModel = response;
        Logger().v(getTransactionByTxnResponseModel);
        Logger().v(response.toJson());
        getTransactionByTxnLoading.value = false;
      });
    }
  }

  bool isPaymentThreeSixty() {
    return selectedPaymentMethod.value!.id == 5 ||
        selectedPaymentMethod.value!.id == 6;
  }

  ReceiverInfoViewModel receiverInfoViewModel = sl();

  double get adminFee => receiverInfoViewModel.adminFeeGet;

  double get gatewayFee =>
      (selectedPaymentMethod.value!.charges as num).toDouble();

  void setTotalFee() {
    PaymentDetailsViewModel paymentDetailsViewModel =
        GetIt.I.get<PaymentDetailsViewModel>();

    if (isRepeatTransaction || fromChangePaymentMethod) {
      receiverInfoViewModel.adminFee = updateTransaction!.adminFee;
    }

    if (fromChangePaymentMethod) {
      totalFee.value = adminFee + gatewayFee + updateTransaction!.totalFee;
      // totalFee.value = adminFee +  updateTransaction!.totalFee;

      notifyListeners();
    } else {
      double payoutPartnerFee =
          paymentDetailsViewModel.receiverPayoutPartner.value != null
              ? paymentDetailsViewModel.receiverPayoutPartner.value!.fee
              : 0;
      totalFee.value = adminFee + gatewayFee + payoutPartnerFee;
      // totalFee.value = adminFee  + payoutPartnerFee;
      // totalFee.value = adminFee  ;

      notifyListeners();
    }
  }

  //
  Future<void> insertPayment(BuildContext context) async {
    if (getPaymentMethodsBodyList.value.isEmpty) {
      return;
    }

    PaymentDetailsViewModel paymentDetailsViewModel =
        GetIt.I.get<PaymentDetailsViewModel>();
    ReceiverViewModel receiverViewModel = GetIt.I.get<ReceiverViewModel>();
    HomeViewModel homeViewModel = GetIt.I.get<HomeViewModel>();
    AccountProvider accountProvider = GetIt.I.get<AccountProvider>();
    CardsViewModel cardsViewModel = GetIt.I.get<CardsViewModel>();
    // int gatewayFee=double.parse(selectedPaymentMethod.value!.charges).toInt();
    double payoutPartnerFee =
        paymentDetailsViewModel.receiverPayoutPartner.value != null
            ? paymentDetailsViewModel.receiverPayoutPartner.value!.fee
            : 0;
    double totalFee = adminFee + gatewayFee;
    // double totalFee = adminFee ;
    if (!paymentDetailsViewModel.isAccountDeposit.value) {
      totalFee = totalFee + payoutPartnerFee;
      // totalFee = totalFee ;
    }
    var params;
    transactionStatus.value = 'Pending';
    if (fromChangePaymentMethod) {
      params = InsertPaymentTransferRequestModel(
          id: updateTransaction!.id,
          txn: updateTransaction!.txn,
          paymentGatewayId: Encryption.encryptObject(
              selectedPaymentMethod.value!.id.toString()),
          isSetToDraft: false,
          deliveredAmount: updateTransaction!.deliveredAmount.toDouble(),
          payoutMethodId: updateTransaction!.payoutMethodId,
          sendingAmount: updateTransaction!.sendingAmount.toDouble(),
          payoutPartnerId: updateTransaction!.payoutPartnerId,
          // sendingAmountWithFee: int.parse(paymentDetailsViewModel.sendMoneyController.text)+totalFee,
          receivingAmount: deliveringAmountUpdateTransaction(),
          receivingCountryCurrencyId:
              updateTransaction!.receiverCountryCurrencyID,
          discount: 0,
          status: 0,
          receiverId: receiverViewModel.selectedReceiver.value!.receiverId,
          receiverBankAccountId:
              updateTransaction!.payoutMethod != 'Account Deposit'
                  ? ''
                  : receiverViewModel.selectedReceiverBank.value!.id,
          partnerTxn: '',
          isIBFT: updateTransaction!.payoutMethod == 'Account Deposit',
          ip: '0.0.0.0',
          // ip: accountProvider.ip,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          userId: Encryption.encryptObject(
              homeViewModel.profileHeader!.profileHeaderBody[0].userID),
          companyId: 'gfju6q24Ox9MmN8MuhUoVw==',
          senderCardId: cardsViewModel.selectedCard != null
              ? cardsViewModel.selectedCard!.id
              : '',
          arrivingTime:
              (selectedPaymentMethod.value!.arrivalTime as num).toInt(),
          promoCode: '',
          receiverCountryId: Encryption.encryptObject(
              receiverViewModel.selectedReceiver.value!.countryId.toString()),
          isScheduled: isSchedule.value,
          exchangeRate: updateTransaction!.exchangeRate,
          reason: updateTransaction!.reason,
          administrativeFee: context.read<ReceiverInfoViewModel>().adminFee,
          payoutPartnerFee: updateTransaction!.payoutPartnerFee,
          payoutMethodFee: updateTransaction!.payoutMethodFee,
          paymentGatewayFee: gatewayFee,
          totalFee: totalFee);
      insertPaymentLoading.value = true;
      var insertPaymentEither = await updatePaymentUsecase.call(params);
      if (insertPaymentEither.isLeft()) {
        handleError(insertPaymentEither);
        insertPaymentLoading.value = false;
      } else if (insertPaymentEither.isRight()) {
        insertPaymentEither.foldRight(null, (response, _) {
          DashboardViewModel dashboardViewModel = sl();
          dashboardViewModel.getTransactionList();

          insertPaymentTransferResponseModal = response;
          if (response.payIdBankResponseModal != null) {
            _handlePayId(response.payIdBankResponseModal!);
            _getTransactionByTxn(response.payIdBankResponseModal!.Body.txn);
          } else if (response.polyResponseModal != null) {
            _handlePoly(response.polyResponseModal!, context);
            _getTransactionByTxn(
                response.polyResponseModal!.Body.txn);
          } else if (response.threeSixtyResponseModal != null) {
            _handleThreeSixty(response.threeSixtyResponseModal!, context);
            _getTransactionByTxn(
                response.threeSixtyResponseModal!.Body.txn);
          } else if (response.manualBankResponseModal != null) {
            _handleManualBankTransfer(response.manualBankResponseModal!);
            _getTransactionByTxn(response.manualBankResponseModal!.Body.txn);
          }
        });
        insertPaymentLoading.value = false;
      }
    } else {
      params = InsertPaymentTransferRequestModel(
          txn: '',
          id: '',
          paymentGatewayId: Encryption.encryptObject(
              selectedPaymentMethod.value!.id.toString()),
          isSetToDraft: false,
          deliveredAmount: deliveringAmount(),
          payoutMethodId:
              paymentDetailsViewModel.receiverPayoutMethod.value!.id,
          sendingAmount:
              double.parse(paymentDetailsViewModel.sendMoneyController.text),
          payoutPartnerId:
              paymentDetailsViewModel.receiverPayoutMethod.value!.name ==
                      'Account Deposit'
                  ? ''
                  : paymentDetailsViewModel.receiverPayoutPartner.value!.id,
          // sendingAmountWithFee: int.parse(paymentDetailsViewModel.sendMoneyController.text)+totalFee,
          receivingAmount: (deliveringAmount() *
              paymentDetailsViewModel.getExchageRate().toInt()),
          receivingCountryCurrencyId:
              paymentDetailsViewModel.receiverCurrency.value!.id,
          discount: 0,
          status: 0,
          receiverId: receiverViewModel.selectedReceiver.value!.receiverId,
          receiverBankAccountId:
              paymentDetailsViewModel.receiverPayoutMethod.value!.name !=
                      'Account Deposit'
                  ? ''
                  : receiverViewModel.selectedReceiverBank.value!.id,
          partnerTxn: '',
          isIBFT: paymentDetailsViewModel.receiverPayoutMethod.value!.name ==
              'Account Deposit',
          // ip: accountProvider.ip,
          ip: '0.0.0.0',
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          userId: Encryption.encryptObject(
              homeViewModel.profileHeader!.profileHeaderBody[0].userID),
          companyId: 'gfju6q24Ox9MmN8MuhUoVw==',
          senderCardId: cardsViewModel.selectedCard != null
              ? cardsViewModel.selectedCard!.id
              : '',
          arrivingTime: (selectedPaymentMethod.value!.arrivalTime as num).toInt(),
          promoCode: '',
          receiverCountryId: paymentDetailsViewModel.receiverCountry!.id,
          isScheduled: isSchedule.value,
          exchangeRate: paymentDetailsViewModel.getExchageRate().toDouble(),
          reason: paymentDetailsViewModel.reasonController.text,
          administrativeFee: context.read<ReceiverInfoViewModel>().adminFee,
          payoutPartnerFee: payoutPartnerFee,
          payoutMethodFee: paymentDetailsViewModel.receiverPayoutMethod.value!.fee,
          paymentGatewayFee: gatewayFee,
          totalFee: totalFee);
      insertPaymentLoading.value = true;
      var insertPaymentEither = await insertPaymentUsecase.call(params);
      if (insertPaymentEither.isLeft()) {
        handleError(insertPaymentEither);
        insertPaymentLoading.value = false;
      } else if (insertPaymentEither.isRight()) {
        insertPaymentEither.foldRight(null, (response, _) {
          DashboardViewModel dashboardViewModel = sl();
          dashboardViewModel.getTransactionList();
          insertPaymentTransferResponseModal = response;

          if (response.payIdBankResponseModal != null) {
            _handlePayId(response.payIdBankResponseModal!);
            _getTransactionByTxn(response.payIdBankResponseModal!.Body.txn);
          } else if (response.polyResponseModal != null) {
            _handlePoly(response.polyResponseModal!, context);
            _getTransactionByTxn(
                response.polyResponseModal!.Body.txn);
          } else if (response.threeSixtyResponseModal != null) {
            _handleThreeSixty(response.threeSixtyResponseModal!, context);
            _getTransactionByTxn(
                response.threeSixtyResponseModal!.Body.txn);
          } else if (response.manualBankResponseModal != null) {
            _handleManualBankTransfer(response.manualBankResponseModal!);
            _getTransactionByTxn(response.manualBankResponseModal!.Body.txn);
          }
        });
        insertPaymentLoading.value = false;
      }
    }
  }

  // Future<void> insertPayment() async {}
  // Methods
  _handleThreeSixty(
      TransectionThreeSixtyResponseModal modal, BuildContext context) async {
    if (modal.Body.checkout.redirect_url.isEmpty) {
      return onErrorMessage
          ?.call(OnErrorMessageModel(message: 'Error in redirect URL'));
    }
    transactionStatus.value = 'Cancelled';

    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            WebViewContent(url: modal.Body.checkout.redirect_url)));

    appState.currentAction = PageAction(
        state: PageState.replace,
        page: PageConfigs.summaryDetailsScreenPageConfig);
  }

  _handlePoly(
    PolyResponseModal modal,
    BuildContext context,
  ) async {
    if (modal.Body.navigateURL.isEmpty) {
      return onErrorMessage
          ?.call(OnErrorMessageModel(message: 'Error in redirect URL'));
    }
    transactionStatus.value = 'Cancelled';

    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebViewContent(url: modal.Body.navigateURL)));
    appState.currentAction = PageAction(
        state: PageState.replace,
        page: PageConfigs.summaryDetailsScreenPageConfig);

    // context.show(message: "It has waited");
  }

  /// To get all transactions details for summary screen
  _getTransactionByTxn(String txn) {
    getTransactionByTxn(txn);
  }

  _handlePayId(PayIdBankResponseModal modal) async {
    isManualBankGateway = false;
    payIdResponseModal = modal;
    if (selectedPaymentMethod.value!.id == 8) {
      goToPayIdOrManualBank();
    }
  }

  _handleManualBankTransfer(ManualBankResponseModal modal) async {
    manualBankResponseModal = modal;
    isManualBankGateway = true;

    if (selectedPaymentMethod.value!.id == 9) {
      goToPayIdOrManualBank();
    }
  }

  double deliveringAmount() {
    PaymentDetailsViewModel _paymentDetails = sl();
    return ((double.parse(_paymentDetails.sendMoneyController.text) -
            totalFee.value) as num)
        .toDouble();
  }

  double deliveringAmountUpdateTransaction() {
    PaymentDetailsViewModel _paymentDetails = sl();
    return ((updateTransaction!.sendingAmount - totalFee.value) as num)
        .toDouble();
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
