class AppUrl {
  static const String baseUrl = 'http://';
  static const String fileBaseUrl = 'http://';
  static const String registerUrl = 'Authentication/Register';
  static const String loginUrl = 'Authentication/Login';
  static const String logoutUrl = 'Authentication/Logout';
  static const String resetUrl = 'Authentication/ResetPassword';
  static const String forgotPasswordUrl = 'Authentication/ForgotPassword';
  static const String validateOtpUrl = 'Authentication/ValidateOTP';
  static const String getCountriesUrl = 'Util/AllCountriesGet';
  static const String getUremitBanksCountriesUrl = 'Util/GetUremitBanksCountry';
  static const String getShortRateListUrl = 'Website/GetShortRateList';
  static const String generateOtpUrl = 'Authentication/GenerateOTP';
  static const String getAllCardsUrl = 'Card/GetAll';
  static const String deleteCardUrl = 'Card/Delete';
  static const String changePasswordUrl = 'Authentication/ChangePassword';
  static const String getPromotionListUrl = 'Dashboard/GetPromotionList';
  static const String getTransactionListUrl = 'Dashboard/GetTransactionList';
  static const String getProfileUrl = 'Setting/GetProfile';
  static const String getRequiredFileUrl = 'Setting/GetRequiredFiles';
  static const String getProvincesUrl = 'Util/GetProvinceListByCountry';
  static const String getDocTypesUrl = 'Util/DocumentType';
  static const String getPaymentMethodList =
      'PaymentFlow/GetGatewayChargesList';
  static const String getAdministrativeChargesList =
      'PaymentFlow/GetAdministrativeChargesList';

  // this header url will change and adjust in profile model
  static const String profileHeaderUrl = 'Setting/DashboardProfileDetail';
  static const String getPreviousFilesUrl = 'Setting/GetPreviousFiles';
  static const String setProfileUrl = 'Setting/SetProfile';
  static const String docRequiredUrl = 'Setting/UploadFile';

  // this header url will change and adjust in receiver model
  static const String profileImageUrl = 'Dashboard/DashboardProfileImage';
  static const String addReceiverBankUrl = 'Receiver/AddReceiverBank';
  static const String addReceiverUrl = 'Receiver/ReceiverAdd';
  static const String getBankListsUrl = 'Receiver/GetBankList';
  static const String deleteReceiverBankUrl = 'Receiver/DeleteReceiverBank';
  static const String updateReceiverNickNameUrl =
      'Receiver/UpdateReceiverNickName';
  static const String deleteReceiverUrl = 'Receiver/DeleteReceiver';
  static const String receiverListUrl = 'Receiver/ReceiverList';
  static const String validateBankUrl = 'Receiver/BankValidation';

  // this header Url will contain the paymentFlow
  static const String getRateListsUrl = 'PaymentFlow/GetRateList';
  static const String getGatewayChargesList =
      'PaymentFlow/GetGatewayChargesList';
  static const String insertPaymentTransferUrl =
      'PaymentFlow/InsertPaymentTransfer';
  static const String updatePaymentTransferUrl =
      'PaymentFlow/UpdatePaymentTransfer';
  static const String insertPaymentProof = 'PaymentFlow/InsertPaymentProof';
  static const String updateTransactionStatus =
      'PaymentFlow/UpdateTransactionStatus';
  static const String paymentHeaderDetails =
      'PaymentFlow/GetBirthCountryExchangeRate';
  static const String getReceiverCurrenciesUrl = 'Util/GetCountryCurrencyList';
  static const String profileAdminApprovelUrl = 'Setting/GetAdminApprovedStatus';
  static const String getTransactionByTxnUrl = 'Dashboard/GetMoneyTransferByTxn';
}
