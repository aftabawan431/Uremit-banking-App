import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/manager/auth_wrapper_view_model.dart';
import 'package:uremit/features/authentication/rates/models/get_rate_list_response_model.dart';
import 'package:uremit/features/authentication/rates/usecases/get_rate_list_usecase.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';
import 'package:uremit/utils/validators/form_validator.dart';

import '../../../../../app/globals.dart';
import '../../../../../services/error/failure.dart';
import '../../../../../services/models/no_params.dart';
import '../../../../../utils/router/app_state.dart';

class RatesViewModel extends ChangeNotifier {
  RatesViewModel(this.getRateListUsecase);

  // Usecases
  GetRateListUsecase getRateListUsecase;

  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> sendEnabledNotifier = ValueNotifier(true);
  ValueNotifier<String> prefixIconPathNotifier =
      ValueNotifier(AppAssets.icCountrySvg);
  ValueNotifier<bool> networkPrefixNotifier = ValueNotifier(false);
  ValueNotifier<String> exchangeRateNotifier = ValueNotifier('');
  ValueNotifier<String> destinationNationCurrencyNotifier = ValueNotifier('');

  bool isSendMoneyError = false;
  bool isButtonPressed = false;

  // Properties
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> ratesFormKey = GlobalKey<FormState>();

  final String destinationCountryLabelText = 'Destination Country';
  final String destinationCountryHintText = 'Select Destination Country';
  final TextEditingController destinationCountryController =
      TextEditingController();
  final FocusNode destinationCountryFocusNode = FocusNode();

  final String sendMoneyLabelText = 'Send Money';
  final String sendMoneyHintText = 'Enter Amount';
  final TextEditingController sendMoneyController = TextEditingController();
  final FocusNode sendMoneyFocusNode = FocusNode();

  final String receivedMoneyLabelText = 'Receiver Gets';
  final String receivedMoneyHintText = 'Received Amount';
  final TextEditingController receivedMoneyController = TextEditingController();
  final FocusNode receivedMoneyFocusNode = FocusNode();

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      locale: 'en_AU', decimalDigits: 0, symbol: 'AUD ');

  GetRateListResponseModel? rateList;

  int selectedCountryIndex = -1;

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AuthWrapperViewModel get _authWrapperViewModel => sl();

  // Usecase Calls
  Future<void> getRateList() async {
    if (rateList != null) {
      return;
    }

    isLoadingNotifier.value = true;
    var modelEither = await getRateListUsecase.call(NoParams());

    if (modelEither.isLeft()) {
      handleError(modelEither);
      isLoadingNotifier.value = false;
      return;
    } else if (modelEither.isRight()) {
      modelEither.foldRight(null, (response, _) {
        rateList = response;
        print('this is the rate list $rateList');
      });
      isLoadingNotifier.value = false;
    }
  }

  void resetFields() {
    destinationCountryController.clear();
    sendMoneyController.clear();
    receivedMoneyController.clear();
    networkPrefixNotifier.value = false;
    exchangeRateNotifier.value = '';
    prefixIconPathNotifier.value = AppAssets.icCountrySvg;
  }

  // Methods
  void onSendMoneySubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    print(sendMoneyController.text);
  }

  void onSendMoneyChange(String value) {
    if (rateList == null || selectedCountryIndex == -1) {
      return;
    }

    sendEnabledNotifier.value = selectedCountryIndex != -1 && value.isNotEmpty;
    if (value.isEmpty) {
      receivedMoneyController.text = '';
      return;
    }
    double rate = double.parse(value);
    receivedMoneyController.text =
        (rate * rateList!.rateListBody[selectedCountryIndex].exchangeRate)
            .toStringAsFixed(2);
  }

  void send() {
    _authWrapperViewModel.bottomNavigationKey.currentState?.setPage(0);
    isButtonPressed = true;
  }
  //validations

  String? validateCountry(String? value) {
    return FormValidators.validateCountry(value);
  }

  String? validateAmount(String? value) {
    return FormValidators.validateSendMoney(value);
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
