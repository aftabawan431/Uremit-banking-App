import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_proof_response_modal.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_response_request_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/getPaymentMethodResponseModal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_transfer_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/paid_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/poly_response_modal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/transection_three_sixty_respose_modal.dart';

import '../../app/models/profile_header_request_model.dart';
import '../../app/models/profile_header_response_model.dart';
import '../../features/authentication/rates/models/get_rate_list_response_model.dart';
import '../../features/cards/models/delete_card_request_model.dart';
import '../../features/cards/models/delete_card_response_model.dart';
import '../../features/cards/models/get_all_cards_request_model.dart';
import '../../features/cards/models/get_all_cards_response_model.dart';
import '../../features/dashboard/models/get_promotion_list_request_model.dart';
import '../../features/dashboard/models/get_promotion_list_response_model.dart';
import '../../features/dashboard/models/get_transaction_list_request_model.dart';
import '../../features/dashboard/models/get_transaction_list_response_model.dart';
import '../../features/files/previous_files/models/get_previous_file_response_model.dart';
import '../../features/files/previous_files/models/get_previous_files_request_model.dart';
import '../../features/files/required_files/models/get_required_file_response_model.dart';
import '../../features/files/required_files/models/get_required_files_request_model.dart';
import '../../features/home/models/profile_image_request_model.dart';
import '../../features/home/models/profile_image_response_model.dart';
import '../../features/menu/documents/models/doc_requied_request_model.dart';
import '../../features/menu/documents/models/document_required_response_model.dart';
import '../../features/menu/profile/models/get_profile_details_request_model.dart';
import '../../features/menu/profile/models/get_profile_details_response_model.dart';
import '../../features/menu/security/models/change_password_request_model.dart';
import '../../features/menu/security/models/change_password_response_model.dart';
import '../../features/menu/update_profile/models/countries_province_request_model.dart';
import '../../features/menu/update_profile/models/countries_province_response_model.dart';
import '../../features/menu/update_profile/models/doc_type_request_model.dart';
import '../../features/menu/update_profile/models/doc_type_response_model.dart';
import '../../features/menu/update_profile/models/get_countries_response_model.dart';
import '../../features/payment/payment_details/models/get_rate_lists_response_model.dart';
import '../../features/payment/personal_info/models/set_profile_details_request_model.dart';
import '../../features/payment/receiver_info/models/receiver_add_request_list_model.dart';
import '../../features/payment/receiver_info/models/receiver_add_response_list_model.dart';
import '../../features/receivers/models/add_receiver_bank_request_model.dart';
import '../../features/receivers/models/add_receiver_bank_response_model.dart';
import '../../features/receivers/models/delete_receiver_bank_request_model.dart';
import '../../features/receivers/models/delete_receiver_bank_response_model.dart';
import '../../features/receivers/models/delete_receiver_request_model.dart';
import '../../features/receivers/models/delete_receiver_response_model.dart';
import '../../features/receivers/models/get_bank_list_request_model.dart';
import '../../features/receivers/models/get_bank_list_response_model.dart';
import '../../features/receivers/models/receiver_list_request_model.dart';
import '../../features/receivers/models/receiver_list_response_model.dart';
import '../../features/receivers/models/update_receiver_nickname_request_model.dart';
import '../../features/receivers/models/update_receiver_nickname_response_model.dart';
import '../../services/error/failure.dart';
import '../../services/models/error_response_model.dart';
import '../../services/models/no_params.dart';
import '../constants/app_level/app_messages.dart';
import '../constants/app_level/app_url.dart';
import '../encryption/encryption.dart';

abstract class RemoteDataSource {
  /// This method gets the countries list
  /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetCountriesResponseModel] returns the countries list
  /// if unsuccessful the response will be [Failure]
  Future<GetCountriesResponseModel> getCountries(NoParams params);

  /// This method gets the rate list for the countries
  /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetRateListResponseModel] returns the rate list
  /// if unsuccessful the response will be [Failure]
  Future<GetRateListResponseModel> getShortRateList(NoParams params);

  /// This method generates new otp for the specified email
  /// [Input]: [GetAllCardsRequestModel] contains the user id
  /// [Output] : if operation successful returns [GetAllCardsResponseModel] returns the cards list against user id
  /// if unsuccessful the response will be [Failure]
  Future<GetAllCardsResponseModel> getAllCards(GetAllCardsRequestModel params);

  /// This method delete card against user id
  /// [Input]: [DeleteCardRequestModel] contains the user id
  /// [Output] : if operation successful returns [DeleteCardResponseModel] returns the deletion of specific card
  /// if unsuccessful the response will be [Failure]
  Future<DeleteCardResponseModel> deleteCard(DeleteCardRequestModel params);

  /// This method get the old password from the user
  /// [Input]: [ChangePasswordRequestModel] contains the old password and newPassword with userId
  /// [Output] : if operation successful returns [ChangePasswordResponseModel] set the new password
  /// if unsuccessful the response will be [Failure]
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel params);

  /// This method get the details of the user against his userId
  /// [Input]: [GetProfileDetailsRequestModel] contains the userId
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] return the user details like firstName,middleName,dob etc
  /// if unsuccessful the response will be [Failure]
  Future<GetProfileDetailsResponseModel> getProfileDetails(GetProfileDetailsRequestModel params);

  /// This method get required file which may required after the expiration of his specific documents and the user can enter that d
  /// [Input]: [GetRequiredFileRequestModel] contains the userId
  /// [Output] : if operation successful returns [GetRequiredFileResponseModel] return the required files
  /// if unsuccessful the response will be [Failure]
  Future<GetRequiredFileResponseModel> getRequiredFile(GetRequiredFileRequestModel params);

  /// This method get user info
  /// [Input]: [ProfileHeaderRequestModel] contains the userId
  /// [Output] : if operation successful returns [ProfileHeaderResponseModel] return the user details like his name and email etc
  /// if unsuccessful the response will be [Failure]
  Future<ProfileHeaderResponseModel> profileHeader(ProfileHeaderRequestModel params);

  /// This method get user previous files
  /// [Input]: [GetPreviousFilesRequestModel] contains the userId
  /// [Output] : if operation successful returns [GetPreviousFileResponseModel] return the file of the user which he had put
  /// if unsuccessful the response will be [Failure]
  Future<GetPreviousFileResponseModel> getPreviousFiles(GetPreviousFilesRequestModel params);

  /// This method get the user details and update them
  /// [Input]: [SetProfileDetailsRequestModel] contains the user information parameters like firstName,middleName etc
  /// [Output] : if operation successful returns [GetProfileDetailsResponseModel] return the the update names and user's other information
  /// if unsuccessful the response will be [Failure]
  Future<GetProfileDetailsResponseModel> setProfileDetails(SetProfileDetailsRequestModel params);

  /// This method gets the promotion list
  /// [Input]: [GetPromotionListRequestModel] contains the user id
  /// [Output] : if operation successful returns [GetPromotionListResponseModel] returns the promotion list against user id
  /// if unsuccessful the response will be [Failure]
  Future<GetPromotionListResponseModel> getPromotionList(GetPromotionListRequestModel params);

  /// This method gets the transactions list
  /// [Input]: [GetTransactionListRequestModel] contains the user id, year and status
  /// [Output] : if operation successful returns [GetTransactionListResponseModel] returns the transaction list against user id
  /// if unsuccessful the response will be [Failure]
  Future<GetTransactionListResponseModel> getTransactionList(GetTransactionListRequestModel params);

  /// This method gets the receiver list
  /// [Input]: [ReceiverListRequestModel] contains the user id
  /// [Output] : if operation successful returns [ReceiverListResponseModel] returns the receiver list against user id
  /// if unsuccessful the response will be [Failure]
  Future<ReceiverListResponseModel> receiverList(ReceiverListRequestModel params);

  /// This method is to change the profile header image in profile header
  /// [Input]: [ProfileImageRequestModel] contains the user id and the image if existing the the value will be true other vice versa
  /// [Output] : if operation successful returns [ProfileImageResponseModel] returns the the updating of profile image
  /// if unsuccessful the response will be [Failure]
  Future<ProfileImageResponseModel> profileImage(ProfileImageRequestModel params);

  /// This method is to add the bank of receiver side
  /// [Input]: [AddReceiverBankRequestModel] contains the userId,receiverId,accountNo,branchCode etc
  /// [Output] : if operation successful returns [AddReceiverBankResponseModel] returns the status of creating the account by True/false.
  /// if unsuccessful the response will be [Failure]
  Future<AddReceiverBankResponseModel> addReceiverBank(AddReceiverBankRequestModel params);

  /// This method is to delete lists of the banks
  /// [Input]: [DeleteReceiverBankListRequestModel] contains the user id
  /// [Output] : if operation successful returns [DeleteReceiverBankListResponseModel] returns the the deletion of the bank list by true/false
  /// if unsuccessful the response will be [Failure]
  Future<DeleteReceiverBankListResponseModel> deleteReceiverBank(DeleteReceiverBankListRequestModel params);

  /// This method is to delete the Receiver from the data
  /// [Input]: [DeleteReceiverRequestModel] contains the receiverId
  /// [Output] : if operation successful returns [DeleteReceiverResponseModel] returns the deletion of receiver by true or false
  /// if unsuccessful the response will be [Failure]
  Future<DeleteReceiverResponseModel> deleteReceiver(DeleteReceiverRequestModel params);

  /// This method gets the rate list for the countries
  /// [Input]: [NoParams] contains no params
  /// [Output] : if operation successful returns [GetPaymentRateListResponseModal] returns the rate list
  /// if unsuccessful the response will be [Failure]
  Future<GetPaymentRateListResponseModal> getRateLists(NoParams params);

  /// This method is to get the bank lists
  /// [Input]: [GetBankListRequestModel] contains the countryID
  /// [Output] : if operation successful returns [GetBankListResponseModel] returns the bankId and name
  /// if unsuccessful the response will be [Failure]
  Future<GetBankListResponseModel> getBankList(GetBankListRequestModel params);

  /// This method is to add the new receiver
  /// [Input]: [ReceiverAddRequestListModel] contains the userId,firstName,middle and last name and email etc
  /// [Output] : if operation successful returns [ReceiverAddResponseListModel] returns the receiverID
  /// if unsuccessful the response will be [Failure]
  Future<ReceiverAddResponseListModel> receiverAdd(ReceiverAddRequestListModel params);

  /// This method is to update the receivers nickname
  /// [Input]: [UpdateReceiverNicknameRequestModel] contains the receiverId and nickname
  /// [Output] : if operation successful returns [UpdateReceiverNicknameResponseModel] returns the up-gradation of nickname by true or false
  /// if unsuccessful the response will be [Failure]
  Future<UpdateReceiverNicknameResponseModel> updateReceiverNickname(UpdateReceiverNicknameRequestModel params);

  /// This method is to get provinces of a country
  /// [Input]: [CountriesProvinceRequestModel] contains the country id
  /// [Output] : if operation successful returns [CountriesProvinceResponseModel] returns the list of provinces of a country
  /// if unsuccessful the response will be [Failure]
  Future<CountriesProvinceResponseModel> getCountryProvinces(CountriesProvinceRequestModel params);

  /// This method is to get doc types
  /// [Input]: [DocTypeRequestModel] contains the visibility to user
  /// [Output] : if operation successful returns [DocTypeResponseModel] returns the list of doc types
  /// if unsuccessful the response will be [Failure]
  Future<DocTypeResponseModel> getDocTypes(DocTypeRequestModel params);

  Future<GetPaymentMethodResponseModal> getPaymentMethods(NoParams params);

  /// This method set the required documents by the uploadFile request api
  /// [Input]: [DocumentRequiredRequestModel] contains the userId
  /// [Output] : if operation successful returns [DocumentRequiredResponseModel] return the successfull message
  /// if unsuccessful the response will be [Failure]
  Future<DocumentRequiredResponseModel> documentRequired(DocumentRequiredRequestModel params);

  /// This method set the required documents by the uploadFile request api
  /// [Input]: [InsertPaymentProofRequestModal] contains the userId
  /// [Output] : if operation successful returns [InsertPaymentProofResponseModal] return the successfull message
  /// if unsuccessful the response will be [Failure]
  Future<InsertPaymentProofResponseModal> insertPaymentProof(InsertPaymentProofRequestModal params);

  /// This method is to get insert payment request response
  /// [Input]: [InsertPaymentTransferRequestModel] contains data of request for transfering payment
  /// [Output] : if operation successful returns [InsertPaymentTransferResponseModal] returns token with redirect url
  /// if unsuccessful the response will be [Failure]
  Future<InsertPaymentTransferResponseModal> insertPaymentTransfer(InsertPaymentTransferRequestModel params);
}

class RemoteDataSourceImp implements RemoteDataSource {
  Dio dio;
  RemoteDataSourceImp({required this.dio});

  @override
  Future<GetCountriesResponseModel> getCountries(NoParams params) async {
    String url = AppUrl.baseUrl + AppUrl.getCountriesUrl;

    try {
      final response = await dio.get(url);

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);
      // log('this is the response of get countries $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetCountriesResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    } catch (e) {
      print(e);
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    }
  }

  //it is for calculator Rate screen
  @override
  Future<GetRateListResponseModel> getShortRateList(NoParams params) async {
    String url = AppUrl.baseUrl + AppUrl.getShortRateListUrl;

    try {
      final response = await dio.get(url);

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetRateListResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  //it is for payment details screen
  @override
  Future<GetPaymentRateListResponseModal> getRateLists(NoParams params) async {
    String url = AppUrl.baseUrl + AppUrl.getRateListsUrl;

    try {
      final response = await dio.get(url);

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        var object = GetPaymentRateListResponseModal.fromJson(jsonResponse);

        // var object = GetPaymentRateListResponse.fromJson(jsonResponse);

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<GetAllCardsResponseModel> getAllCards(GetAllCardsRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getAllCardsUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      Logger().v(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetAllCardsResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<DeleteCardResponseModel> deleteCard(DeleteCardRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.deleteCardUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );
      print(response);

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return DeleteCardResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.changePasswordUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return ChangePasswordResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<GetProfileDetailsResponseModel> getProfileDetails(GetProfileDetailsRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getProfileUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));

    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);
      print('this is the getProfile response $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetProfileDetailsResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<GetRequiredFileResponseModel> getRequiredFile(GetRequiredFileRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getRequiredFileUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    log(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );
      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);
      Logger().i('this is the first $jsonResponse');
      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetRequiredFileResponseModel.fromJson(jsonResponse);
      }

      Logger().i('this is the last $jsonResponse');

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().v(exception.response);
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<ProfileHeaderResponseModel> profileHeader(ProfileHeaderRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.profileHeaderUrl;
    log('this is the profile header request ${jsonEncode(params)}');
    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return ProfileHeaderResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<GetPreviousFileResponseModel> getPreviousFiles(GetPreviousFilesRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getPreviousFilesUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    print('previous files request $encryptedJson');
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );
      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);
      print('this is the response of previous $jsonResponse');
      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetPreviousFileResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<GetProfileDetailsResponseModel> setProfileDetails(SetProfileDetailsRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.setProfileUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    // log(encryptedJson);
    // log('this is thee encryptedJson $encryptedJson');
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );
      print('this is the message {$response.statusCode}');
      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);
      print('this is the decryptedResponse dude $jsonResponse');
      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return await getProfileDetails(GetProfileDetailsRequestModel(id: params.userId));

        // return GetProfileDetailsResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<GetPromotionListResponseModel> getPromotionList(GetPromotionListRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getPromotionListUrl;
    log('this is the promotion request ${jsonEncode(params)}');
    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetPromotionListResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<ReceiverListResponseModel> receiverList(ReceiverListRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.receiverListUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return ReceiverListResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i(exception);
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<ProfileImageResponseModel> profileImage(ProfileImageRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.profileImageUrl;
    log(jsonEncode(params));
    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return ProfileImageResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<AddReceiverBankResponseModel> addReceiverBank(AddReceiverBankRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.addReceiverBankUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return AddReceiverBankResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<DeleteReceiverResponseModel> deleteReceiver(DeleteReceiverRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.deleteReceiverUrl;
    print(jsonEncode(params));
    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return DeleteReceiverResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<DeleteReceiverBankListResponseModel> deleteReceiverBank(DeleteReceiverBankListRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.deleteReceiverBankUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return DeleteReceiverBankListResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<GetBankListResponseModel> getBankList(GetBankListRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getBankListsUrl;
    Logger().w(params.toJson());

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );
      Logger().i('here');

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      Logger().w(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetBankListResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i(exception);
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<ReceiverAddResponseListModel> receiverAdd(ReceiverAddRequestListModel params) async {
    String url = AppUrl.baseUrl + AppUrl.addReceiverBankUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);
      Logger().w('this is the response of receiver add $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return ReceiverAddResponseListModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<UpdateReceiverNicknameResponseModel> updateReceiverNickname(UpdateReceiverNicknameRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.updateReceiverNickNameUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return UpdateReceiverNicknameResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<CountriesProvinceResponseModel> getCountryProvinces(CountriesProvinceRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getProvincesUrl;

    print(jsonEncode(params));

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return CountriesProvinceResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<DocTypeResponseModel> getDocTypes(DocTypeRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getDocTypesUrl;

    print(jsonEncode(params));

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return DocTypeResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<GetPaymentMethodResponseModal> getPaymentMethods(NoParams params) async {
    String url = AppUrl.baseUrl + AppUrl.getPaymentMethodList;

    try {
      final response = await dio.get(
        url,
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetPaymentMethodResponseModal.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<DocumentRequiredResponseModel> documentRequired(params) async {
    String url = AppUrl.baseUrl + AppUrl.docRequiredUrl;

    log('this is required documents request ${jsonEncode(params)}');

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    print('this is encryptedJson request $encryptedJson');
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      Logger().i('this is response of required documents request $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return DocumentRequiredResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print('hello this is here ${exception.response}');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<InsertPaymentTransferResponseModal> insertPaymentTransfer(params) async {
    String url = AppUrl.baseUrl + AppUrl.insertPaymentTransferUrl;

    Logger().i(params.toJson());
    log(params.toJson().toString());

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      String gatewayId = Encryption.decryptObject(params.paymentGatewayId);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        var modal = InsertPaymentTransferResponseModal();
        if (gatewayId == '5' || gatewayId == '6') {
          modal.threeSixtyResponseModal = TransectionThreeSixtyResponseModal.fromJson(jsonResponse);
        } else if (gatewayId == '7') {
          modal.polyResponseModal = PolyResponseModal.fromJson(jsonResponse);
        } else if (gatewayId == '8') {
          // response of both payid and bank is same
          modal.payIdBankResponseModal = PayIdBankResponseModal.fromJson(jsonResponse);
        } else if (gatewayId == '9') {
          modal.manualBankResponseModal = ManualBankResponseModal.fromJson(jsonResponse);
        }

        return modal;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        Logger().i(errorResponseModel.statusCode);
        Logger().i(errorResponseModel.body);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<InsertPaymentProofResponseModal> insertPaymentProof(params) async {
    String url = AppUrl.baseUrl + AppUrl.insertPaymentProof;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return InsertPaymentProofResponseModal.fromJson(jsonResponse);
      }
      Logger().v('Response');
      Logger().v(jsonResponse);
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        Logger().v(exception.response!.statusCode);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }

  @override
  Future<GetTransactionListResponseModel> getTransactionList(GetTransactionListRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.getTransactionListUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      Logger().i(jsonResponse);
      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return GetTransactionListResponseModel.fromJson(jsonResponse);
      }
      Logger().v('Response');
      // Logger().v(jsonResponse);
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      // Logger().v(exception.message);
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        Logger().v(exception.response!.statusCode);
        throw SomethingWentWrong(errorResponseModel.body.join(' '));
      }
    }
  }
}
