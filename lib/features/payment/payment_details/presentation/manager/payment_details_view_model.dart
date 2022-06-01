import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/services/models/no_params.dart';
import 'package:uremit/services/models/on_error_message_model.dart';

import '../../../../../app/globals.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/validators/form_validator.dart';
import '../../models/get_rate_lists_response_model.dart';
import '../../usecase/get_payment_rate_list_usecase.dart';

class PaymentDetailsViewModel extends ChangeNotifier {
  PaymentDetailsViewModel({required this.getPaymentRateListUsecase});

  // Usecases
  GetPaymentRateListUsecase getPaymentRateListUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isCountryLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isPaymentMethodLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isPayoutPartnerLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isAccountDeposit = ValueNotifier(false);

  bool isPaymentDetailsPageChange = true;
  bool isReceiverCountryError = false;
  bool isPaymentMethodError = false;
  bool isPayoutPartnerError = false;
  bool isSendMoneyError = false;
  bool isReasonError = false;

  List<GetPaymentRateListResponseBody> countriesList = [];
  List<PayoutMethod> payoutMethodsList = [];
  List<PayoutPartner> payoutPartnersList = [];

  // Properties
  final GlobalKey<FormState> paymentDetailsFormKey = GlobalKey<FormState>();

  final FocusNode receiverCountryFocusNode = FocusNode();
  final String receiverCountryLabelText = 'Receiver Country';
  final String receiverCountryHintText = 'Select Receiver\'s Country';
  final TextEditingController receiverCountryController = TextEditingController();

  final FocusNode paymentMethodFocusNode = FocusNode();
  final String paymentMethodLabelText = 'Payment Method';
  final String paymentMethodHintText = 'Select Payment Method';
  final TextEditingController paymentMethodController = TextEditingController();

  final FocusNode payoutPartnerFocusNode = FocusNode();
  final String payoutPartnerLabelText = 'Payout Partner';
  final String payoutPartnerHintText = 'Select Payout Partner';
  final TextEditingController payoutPartnerController = TextEditingController();

  final FocusNode sendMoneyFocusNode = FocusNode();
  final String sendMoneyLabelText = 'Send Money';
  final String sendMoneyHintText = 'Enter Money';
  final TextEditingController sendMoneyController = TextEditingController();

  final FocusNode reasonFocusNode = FocusNode();

  final String reasonCountryLabelText = 'Reason';
  final String reasonHintText = 'Enter Reason (min 20 letters)';
  final TextEditingController reasonController = TextEditingController();
  GetPaymentRateListResponseModal? paymentList;

  CountryPayment? receiverCountry;

  ValueNotifier<PayoutMethod?> receiverPayoutMethod = ValueNotifier(null);
  ValueNotifier<PayoutPartner?> receiverPayoutPartner = ValueNotifier(null);
  // Getters
  AppState appState = GetIt.I.get<AppState>();
  PaymentDetailsViewModel get paymentDetailsViewModel => sl();
  // Usecase Calls
  // Usecase Calls
  Future<void> getRateList([bool recall = false]) async {
    if (!recall) {
      if (paymentList != null) {
        return;
      }
    }

    isLoadingNotifier.value = true;

    var getRateListEither = await getPaymentRateListUsecase(NoParams());
    if (getRateListEither.isLeft()) {
      handleError(getRateListEither);
      isLoadingNotifier.value = false;
    } else if (getRateListEither.isRight()) {
      getRateListEither.foldRight(null, (response, _) {
        paymentList = response;
        print('this is the response of getProfile $paymentList');
      });
      isLoadingNotifier.value = false;

      //
    }
  }

  /// extract payout partners
  ///
  ///
  void emptyPayoutPartners() {
    payoutPartnersList = [];
    notifyListeners();
  }

  void getPayoutPartners() {
    if (payoutPartnersList.isNotEmpty) {
      return;
    }
    if (receiverCountry == null && receiverPayoutMethod == null) {
      return;
    }
    for (var item in paymentList!.getPaymentRateListResponseBody) {
      if (item.country.name == receiverCountry!.name && item.payoutMethod.name == receiverPayoutMethod.value!.name) {
        if (!payoutPartnersList.contains(item.payoutPartner)) {
          payoutPartnersList.add(item.payoutPartner);
        }
      }
    }
    notifyListeners();
  }

  /// extract payment methods

  void emptyPayoutMethods() {
    payoutMethodsList = [];
    notifyListeners();
  }

  void getPayoutMethods() {
    if (payoutMethodsList.isNotEmpty) {
      return;
    }
    if (receiverCountry == null) {
      return;
    }
    for (var item in paymentList!.getPaymentRateListResponseBody) {
      if (item.country.name == receiverCountry!.name) {
        if (!payoutMethodsList.contains(item.payoutMethod)) {
          payoutMethodsList.add(item.payoutMethod);
        }
      }
    }
    notifyListeners();
  }

  double getExchageRate() {
    var object = paymentList!.getPaymentRateListResponseBody.firstWhere((element) => element.payoutMethod.id == receiverPayoutMethod.value!.id);
    return object.exchangeRate.toDouble();
  }

  /// extract unique objects from list of countries
  ///
  void getUniqueCountries() {
    if (countriesList.isNotEmpty) {
      return;
    }

    for (var item in paymentList!.getPaymentRateListResponseBody) {
      if (countriesList.where((element) => element.country.name == item.country.name).isEmpty) {
        countriesList.add(item);
      }
    }

    notifyListeners();
  }

  Future<void> getReceiverCountries() async {
    if (paymentList != null) {
      return;
    }

    isCountryLoadingNotifier.value = true;

    var getReceiverCountriesEither = await getPaymentRateListUsecase.call(NoParams());

    if (getReceiverCountriesEither.isLeft()) {
      handleError(getReceiverCountriesEither);
      isCountryLoadingNotifier.value = false;
    } else if (getReceiverCountriesEither.isRight()) {
      getReceiverCountriesEither.foldRight(null, (response, _) {
        paymentList = response;
      });
      isCountryLoadingNotifier.value = false;
    }
  }

  // Methods

  void clearAllTextFields() {
    reasonController.clear();
    sendMoneyController.clear();
    paymentMethodController.clear();
    receiverCountryController.clear();
    payoutPartnerController.clear();
    receiverPayoutMethod.value=null;
    receiverPayoutPartner.value=null;
    ReceiverViewModel receiverViewModel=sl();
    receiverViewModel.selectedReceiver.value=null;

  }

  void onReceiverCountrySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(paymentMethodFocusNode);
  }

  void onPaymentMethodSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(payoutPartnerFocusNode);
  }

  void onPayoutPartnerSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(sendMoneyFocusNode);
  }

  void onSendMoneySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(reasonFocusNode);
  }

  void onReasonSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String? validateReceiverCountry(String? value) {
    if (!isPaymentDetailsPageChange) {
      return null;
    }
    isReceiverCountryError = true;
    var result = FormValidators.validateCountry(value?.trim());
    print(result);
    if (result == null) {
      isReceiverCountryError = false;
    }
    return result;
  }

  void onReceiverCountryChange(String value) {
    isPaymentDetailsPageChange = false;
    if (isReceiverCountryError) {
      paymentDetailsFormKey.currentState!.validate();
    }
  }

  String? validatePaymentMethod(String? value) {
    if (!isPaymentDetailsPageChange) {
      return null;
    }
    isPaymentMethodError = true;
    var result = FormValidators.validateCountry(value?.trim());
    if (result == null) {
      isPaymentMethodError = false;
    }
    return result;
  }

  void onPaymentMethodChange(String value) {
    isPaymentDetailsPageChange = false;
    if (isPaymentMethodError) {
      paymentDetailsFormKey.currentState!.validate();
    }
  }

  String? validatePayoutPartner(String? value) {
    if (!isPaymentDetailsPageChange) {
      return null;
    }
    isPayoutPartnerError = true;
    var result = FormValidators.validatePayoutPartner(value?.trim());
    if (result == null) {
      isPayoutPartnerError = false;
    }
    return result;
  }

  void onPayoutPartnerChange(String value) {
    isPaymentDetailsPageChange = false;
    if (isPayoutPartnerError) {
      paymentDetailsFormKey.currentState!.validate();
    }
  }

  String? validateSendMoney(String? value) {
    if (!isPaymentDetailsPageChange) {
      return null;
    }
    isSendMoneyError = true;
    var result = FormValidators.validateSendMoney(value?.trim());
    if (result == null) {
      isSendMoneyError = false;
    }
    return result;
  }

  void onSendMoneyChange(String value) {
    isPaymentDetailsPageChange = false;
    if (isSendMoneyError) {
      paymentDetailsFormKey.currentState!.validate();
    }
  }

  String? validateReason(String? value) {
    if (!isPaymentDetailsPageChange) {
      return null;
    }
    isReasonError = true;
    var result = FormValidators.validateReason(value?.trim());
    if (result == null) {
      isReasonError = false;
    }
    return result;
  }

  void onReasonChange(String value) {
    isPaymentDetailsPageChange = false;
    if (isReasonError) {
      paymentDetailsFormKey.currentState!.validate();
    }
  }

  bool validateForm() {
    isPaymentDetailsPageChange = true;
    return paymentDetailsFormKey.currentState!.validate();
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

// Page Moves
}
