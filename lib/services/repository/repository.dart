import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/forgot_password/models/forgot_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_response_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_response_model.dart';
import 'package:uremit/features/authentication/login/models/login_request_model.dart';
import 'package:uremit/features/authentication/login/models/login_response_model.dart';
import 'package:uremit/features/authentication/rates/models/get_rate_list_response_model.dart';
import 'package:uremit/features/authentication/registration/models/registration_request_model.dart';
import 'package:uremit/features/authentication/registration/models/registration_response_model.dart';
import 'package:uremit/features/cards/models/delete_card_request_model.dart';
import 'package:uremit/features/cards/models/delete_card_response_model.dart';
import 'package:uremit/features/cards/models/get_all_cards_request_model.dart';
import 'package:uremit/features/cards/models/get_all_cards_response_model.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_request_model.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_response_model.dart';
import 'package:uremit/features/files/previous_files/models/get_previous_file_response_model.dart';
import 'package:uremit/features/files/previous_files/models/get_previous_files_request_model.dart';
import 'package:uremit/features/home/models/get_profile_admin_approval_response_model.dart';
import 'package:uremit/features/home/models/get_profile_admin_approvel_request_model.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_request_model.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_response_model.dart';
import 'package:uremit/features/menu/security/models/change_password_request_model.dart';
import 'package:uremit/features/menu/security/models/change_password_response_model.dart';
import 'package:uremit/features/menu/update_profile/models/countries_province_response_model.dart';
import 'package:uremit/features/menu/update_profile/models/doc_type_request_model.dart';
import 'package:uremit/features/menu/update_profile/models/doc_type_response_model.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_proof_response_modal.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_response_request_modal.dart';
import 'package:uremit/features/payment/payment_details/models/get_receiver_currencies_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_Payment_Method_Response_Model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_transaction_by%20_txn_response_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_transaction_by_txn_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_transfer_request_model.dart';
import 'package:uremit/features/payment/receiver_info/models/get_administrative_charges_list_response_model.dart';
import 'package:uremit/features/payment/receiver_info/models/get_admistrative_charges_list_request_model.dart';
import 'package:uremit/features/payment/receiver_info/models/receiver_add_request_list_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_request_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_response_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_request_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_response_model.dart';
import 'package:uremit/features/receivers/models/payment_header_response_model.dart';
import 'package:uremit/features/receivers/models/receiver_list_request_model.dart';
import 'package:uremit/features/receivers/models/receiver_list_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/models/no_params.dart';

import '../../app/models/profile_header_request_model.dart';
import '../../app/models/profile_header_response_model.dart';
import '../../features/authentication/login/models/logout_request_model.dart';
import '../../features/authentication/login/models/logout_response_model.dart';
import '../../features/authentication/otp/models/generate_otp_request_model.dart';
import '../../features/dashboard/models/get_transaction_list_request_model.dart';
import '../../features/dashboard/models/get_transaction_list_response_model.dart';
import '../../features/files/required_files/models/get_required_file_response_model.dart';
import '../../features/files/required_files/models/get_required_files_request_model.dart';
import '../../features/home/models/profile_image_request_model.dart';
import '../../features/home/models/profile_image_response_model.dart';
import '../../features/menu/documents/models/doc_requied_request_model.dart';
import '../../features/menu/documents/models/document_required_response_model.dart';
import '../../features/menu/update_profile/models/countries_province_request_model.dart';
import '../../features/menu/update_profile/models/get_countries_response_model.dart';
import '../../features/payment/payment_details/models/get_rate_lists_response_model.dart';
import '../../features/payment/payment_details/models/get_receiver_currencies_response_model.dart';
import '../../features/payment/payment_details/models/update_transaction_status_request_model.dart';
import '../../features/payment/payment_details/models/update_transaction_status_response_model.dart';
import '../../features/payment/personal_info/models/set_profile_details_request_model.dart';
import '../../features/payment/receipt_screen/modal/get_payment_methods_request_model.dart';
import '../../features/payment/receiver_info/models/get_uremit_banks_countires_response_model.dart';
import '../../features/payment/receiver_info/models/receiver_add_response_list_model.dart';
import '../../features/receivers/models/add_receiver_bank_request_model.dart';
import '../../features/receivers/models/add_receiver_bank_response_model.dart';
import '../../features/receivers/models/delete_receiver_bank_request_model.dart';
import '../../features/receivers/models/delete_receiver_bank_response_model.dart';
import '../../features/receivers/models/payment_header_request_model.dart';
import '../../features/receivers/models/update_receiver_nickname_request_model.dart';
import '../../features/receivers/models/update_receiver_nickname_response_model.dart';
import '../../features/receivers/models/validate_bank_request_model.dart';
import '../../features/receivers/models/validate_bank_response_model.dart';

abstract class Repository {
  /// This method register the user against their credentials (email and phone number)
  /// [Input]: [RegistrationRequestModel] contains the user information
  /// [Output] : if operation successful returns [RegistrationResponseModel] returns the user email
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, RegistrationResponseModel>> registerUser(RegistrationRequestModel params);

  /// This method register the user against their credentials (email and phone number)
  /// [Input]: [LoginRequestModel] contains the user information
  /// [Output] : if operation successful returns [LoginResponseModel] returns the user email
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel params);

  /// This method logout the user against their credentials (email and phone number)
  /// [Input]: [LogoutRequestModel] contains the user information
  /// [Output] : if operation successful returns [LogoutResponseModel] returns the user email
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, LogoutResponseModel>> logoutUser(LogoutRequestModel params);

  /// This method reset the password is to change the user password against his old password
  /// [Input]: [ResetPasswordRequestModel] contains the user old password
  /// [Output] : if operation successful returns [ResetPasswordResponseModel] returns the otp
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ResetPasswordResponseModel>> resetPassword(ResetPasswordRequestModel params);

  /// This method is implemented when forgot his password and want to approach his password
  /// [Input]: [ForgotPasswordRequestModel] contains the email
  /// [Output] : if operation successful returns [NoParams] returns the ok status
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, NoParams>> forgotPassword(ForgotPasswordRequestModel params);

  /// This method reset the password is to change the user password against his old password
  /// [Input]: [ValidateOtpRequestModel] contains the user old password
  /// [Output] : if operation successful returns [ValidateOtpResponseModel] returns the otp
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ValidateOtpResponseModel>> validateOtp(ValidateOtpRequestModel params);

  /// This method gets the countries list
  /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetCountriesResponseModel] returns the countries list
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetCountriesResponseModel>> getCountries(NoParams params);

  /// This method gets the countries list associated with uremit
  /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetUremitBanksCountriesResponseModel] returns the countries list  associated with uremit
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetUremitBanksCountriesResponseModel>> getUremitBanksCountries(NoParams params);

  /// This method gets the rate list for the countries
  /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetRateListResponseModel] returns the rate list
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetRateListResponseModel>> getShortRateList(NoParams params);

  /// This method gets the rate list for the countries
  /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetPaymentRateListResponseModal] returns the rate list
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetPaymentRateListResponseModal>> getRateLists(NoParams params);

  /// This method generates new otp for the specified email
  /// [Input]: [GenerateOtpRequestModel] contains the user email
  /// [Output] : if operation successful returns [NoParams] returns the just ok status
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, NoParams>> generateOtp(GenerateOtpRequestModel params);

  /// This method gets all the cards against user id
  /// [Input]: [GetAllCardsRequestModel] contains the user id
  /// [Output] : if operation successful returns [GetAllCardsResponseModel] returns the cards list against user id
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetAllCardsResponseModel>> getAllCards(GetAllCardsRequestModel params);

  /// This method delete card against user id
  /// [Input]: [DeleteCardRequestModel] contains the user id
  /// [Output] : if operation successful returns [DeleteCardResponseModel] returns the deletion of specific card
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, DeleteCardResponseModel>> deleteCard(DeleteCardRequestModel params);

  /// This method validate the bank against bank account no. and bank id
  /// [Input]: [ValidateBankRequestModel] contains the bank account no. and bank id
  /// [Output] : if operation successful returns [ValidateBankResponseModel] returns the account details like num,title and etc
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ValidateBankResponseModel>> validateBank(ValidateBankRequestModel params);

  /// This method get the old password from the user
  /// [Input]: [ChangePasswordRequestModel] contains the old password and newPassword with userId
  /// [Output] : if operation successful returns [ChangePasswordResponseModel] set the new password
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ChangePasswordResponseModel>> changePassword(ChangePasswordRequestModel params);

  /// This method get the details of the user against his userId
  /// [Input]: [GetProfileDetailsRequestModel] contains the userId
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] return the user details like firstName,middleName,dob etc
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetProfileDetailsResponseModel>> getProfileDetails(GetProfileDetailsRequestModel params);

  /// This method get required file which may required after the expiration of his specific documents and the user can enter that details
  /// [Input]: [GetRequiredFileRequestModel] contains the userId
  /// [Output] : if operation successful returns [GetRequiredFileResponseModel] return the required files
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetRequiredFileResponseModel>> getRequiredFiles(GetRequiredFileRequestModel params);

  /// This method set the required documents by the uploadFile request api
  /// [Input]: [DocumentRequiredRequestModel] contains the userId
  /// [Output] : if operation successful returns [DocumentRequiredResponseModel] return the successfull message
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, DocumentRequiredResponseModel>> documentRequired(DocumentRequiredRequestModel params);

  /// This method get user info
  /// [Input]: [ProfileHeaderRequestModel] contains the userId
  /// [Output] : if operation successful returns [ProfileHeaderResponseModel] return the user details like his name and email etc
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ProfileHeaderResponseModel>> profileHeader(ProfileHeaderRequestModel params);

  /// This method get user previous files
  /// [Input]: [GetPreviousFilesRequestModel] contains the userId
  /// [Output] : if operation successful returns [GetPreviousFileResponseModel] return the file of the user which he had put
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetPreviousFileResponseModel>> getPreviousFiles(GetPreviousFilesRequestModel params);

  /// This method get the user details and update them
  /// [Input]: [SetProfileDetailsRequestModel] contains the user information parameters like firstName,middleName etc
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] return the the update names and user's other information
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetProfileDetailsResponseModel>> setProfileDetails(SetProfileDetailsRequestModel params);

  /// This method gets the promotion list
  /// [Input]: [GetPromotionListRequestModel] contains the user id
  /// [Output] : if operation successful returns [GetPromotionListResponseModel] returns the promotion list against user id
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetPromotionListResponseModel>> getPromotionList(GetPromotionListRequestModel params);

  /// This method gets the transactions list
  /// [Input]: [GetTransactionListRequestModel] contains the user id, year and status
  /// [Output] : if operation successful returns [GetTransactionListResponseModel] returns the transaction list against user id
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetTransactionListResponseModel>> getTransactionList(GetTransactionListRequestModel params);

  /// This method gets the receiver list
  /// [Input]: [ReceiverListRequestModel] contains the user id
  /// [Output] : if operation successful returns [ReceiverListResponseModel] returns the receiver list against user id
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ReceiverListResponseModel>> receiverList(ReceiverListRequestModel params);

  /// This method is to change the profile header image in profile header
  /// [Input]: [ProfileImageRequestModel] contains the user id and the image if existing the the value will be true other vice versa
  /// [Output] : if operation successful returns [ProfileImageResponseModel] returns the the updatation of profile image
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ProfileImageResponseModel>> profileImage(ProfileImageRequestModel params);

  /// This method is to get the admin approvel status of the user update profile
  /// [Input]: [GetProfileAdminApprovelRequestModel] contains the user id
  /// [Output] : if operation successful returns [GetProfileAdminApprovelResponseModel] returns the the status of profile image approval
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetProfileAdminApprovelResponseModel>> profileAdminApprovel(GetProfileAdminApprovelRequestModel params);

  /// This method is to add the bank of receiver side
  /// [Input]: [AddReceiverBankRequestModel] contains the userId,receiverId,accountNo,branchCode etc
  /// [Output] : if operation successful returns [AddReceiverBankResponseModel] returns the status of creating the account by True/false.
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, AddReceiverBankResponseModel>> addReceiverBank(AddReceiverBankRequestModel params);

  /// This method is to delete lists of the banks
  /// [Input]: [DeleteReceiverBankListRequestModel] contains the user id
  /// [Output] : if operation successful returns [DeleteReceiverBankListResponseModel] returns the the deletion of the bank list by true/false
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, DeleteReceiverBankListResponseModel>> deleteReceiverBank(DeleteReceiverBankListRequestModel params);

  /// This method is to delete the Receiver from the data
  /// [Input]: [DeleteReceiverRequestModel] contains the receiverId
  /// [Output] : if operation successful returns [DeleteReceiverResponseModel] returns the deletion of receiver by true or false
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, DeleteReceiverResponseModel>> deleteReceiver(DeleteReceiverRequestModel params);

  /// This method is to get the bank lists
  /// [Input]: [GetBankListRequestModel] contains the countryID
  /// [Output] : if operation successful returns [GetBankListResponseModel] returns the bankId and name
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetBankListResponseModel>> getBankList(GetBankListRequestModel params);

  /// This method is to get the payment details in receiver details info
  /// [Input]: [PaymentHeaderRequestModel] contains the userId
  /// [Output] : if operation successful returns [PaymentHeaderResponseModel] returns the SenderCountryUnitValue and BirthCountryExchangeValue
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, PaymentHeaderResponseModel>> getPaymentHeaderDetails(PaymentHeaderRequestModel params);

  /// This method is to GetAdministrativeChargesList
  /// [Input]: [GetAdministrativeChargesListRequestModel] contains the countryID
  /// [Output] : if operation successful returns [GetAdministrativeChargesListResponseModel] returns the admin fee
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetAdministrativeChargesListResponseModel>> getAdministrativeChargesLists(GetAdministrativeChargesListRequestModel params);

  /// This method is to add the new receiver
  /// [Input]: [ReceiverAddRequestListModel] contains the userId,firstName,middle and last name and email etc
  /// [Output] : if operation successful returns [ReceiverAddResponseListModel] returns the receiverID
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, ReceiverAddResponseListModel>> receiverAdd(ReceiverAddRequestListModel params);

  /// This method is to update the receivers nickname
  /// [Input]: [UpdateReceiverNicknameRequestModel] contains the receiverId and nickname
  /// [Output] : if operation successful returns [UpdateReceiverNicknameResponseModel] returns the up-gradation of nickname by true or false
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, UpdateReceiverNicknameResponseModel>> updateReceiverNickname(UpdateReceiverNicknameRequestModel params);

  /// This method is to get provinces of a country
  /// [Input]: [CountriesProvinceRequestModel] contains the country id
  /// [Output] : if operation successful returns [CountriesProvinceResponseModel] returns the list of provinces of a country
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, CountriesProvinceResponseModel>> getCountryProvinces(CountriesProvinceRequestModel params);

  /// This method is to get doc types
  /// [Input]: [DocTypeRequestModel] contains the visibility to user
  /// [Output] : if operation successful returns [DocTypeResponseModel] returns the list of doc types
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, DocTypeResponseModel>> getDocTypes(DocTypeRequestModel params);

  /// This method is to get payment methods types
  /// [Output] : if operation successful returns [GetPaymentMethodResponseModal] returns the list of payment methods types
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, GetPaymentMethodResponseModal>> getPaymentMethods(GetPaymentMethodsRequestModel params);

  /// This method will send request to Insert Payment Transfer API
  /// [Input]: [InsertPaymentTransferRequestModel] contains the receipt information like method id , gateway id, receiver id etc
  /// [Output] : if operation successful returns [InsertPaymentTransferResponseModal] return the token and redirect URL
  /// if unsuccessful the response will be [Failure]
  ///
  Future<Either<Failure, InsertPaymentTransferResponseModal>> insertPaymentTransfer(InsertPaymentTransferRequestModel params);

  /// This method will send request to Insert Payment Transfer API
  /// [Input]: [InsertPaymentTransferRequestModel] contains the receipt information like method id , gateway id, receiver id etc
  /// [Output] : if operation successful returns [InsertPaymentTransferResponseModal] return the token and redirect URL
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, InsertPaymentTransferResponseModal>> updatePayment(InsertPaymentTransferRequestModel params);

  /// This method set the required documents by the uploadFile request api
  /// [Input]: [InsertPaymentTransferRequestModel] contains the userId
  /// [Output] : if operation successful returns [InsertPaymentTransferResponseModal] return the successfull message
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, InsertPaymentProofResponseModal>> insertPaymentProof(InsertPaymentProofRequestModal params);

  /// This method get the user details and update them
  /// [Input]: [UpdateTransactionStatusRequestModel] contains the user information parameters like firstName,middleName etc
  /// [Output] : if operation successful returns [UpdateTransactionStatusResponseModel] return the the update names and user's other information
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, UpdateTransactionStatusResponseModel>> updateTransactionStatus(UpdateTransactionStatusRequestModel params);
  Future<Either<Failure, GetReceiverCurrenciesResponseModel>> getReceiverCurrencies(GetReceiverCurrenciesRequestModel params);
  Future<Either<Failure, GetTransactionByTxnResponseModel>> getTransactionByTxn(GetTransactionByTxnRequestModel params);
}
