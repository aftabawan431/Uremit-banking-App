import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/authentication/forgot_password/models/forgot_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_response_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_response_model.dart';
import 'package:uremit/features/authentication/login/models/login_request_model.dart';
import 'package:uremit/features/authentication/login/models/login_response_model.dart';
import 'package:uremit/features/authentication/otp/models/generate_otp_request_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/models/error_response_model.dart';
import 'package:uremit/utils/constants/app_level/app_messages.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';
import 'package:uremit/utils/encryption/encryption.dart';

import '../../features/authentication/login/models/logout_request_model.dart';
import '../../features/authentication/login/models/logout_response_model.dart';
import '../../features/authentication/registration/models/registration_request_model.dart';
import '../../features/authentication/registration/models/registration_response_model.dart';
import '../../services/models/no_params.dart';

abstract class AuthDataSource {
  /// This method register the user against their credentials (email and phone number)
  /// [Input]: [RegistrationRequestModel] contains the user information
  /// [Output] : if operation successful returns [RegistrationResponseModel] returns the user email
  /// if unsuccessful the response will be [Failure]
  Future<RegistrationResponseModel> registerUser(RegistrationRequestModel params);

  /// This method login the user as the email and the number which he have registered
  /// [Input]: [LoginRequestModel] contains the user information
  /// [Output] : if operation successful returns [LoginResponseModel] returns the dashboard of the application
  /// if unsuccessful the response will be [Failure]
  Future<LoginResponseModel> loginUser(LoginRequestModel params);

  /// This method logout the user against their credentials (email and phone number)
  /// [Input]: [LogoutRequestModel] contains the user information
  /// [Output] : if operation successful returns [LogoutResponseModel] returns the user email
  /// if unsuccessful the response will be [Failure]
  Future<LogoutResponseModel> logoutUser(LogoutRequestModel params);

  /// This method reset the password is to change the user password against his old password
  /// [Input]: [ResetPasswordRequestModel] contains the user old password
  /// [Output] : if operation successful returns [ResetPasswordResponseModel] returns the screen
  /// if unsuccessful the response will be [Failure]
  Future<ResetPasswordResponseModel> resetPassword(ResetPasswordRequestModel params);

  /// This method is implemented when forgot his password and want to approach his password
  /// [Input]: [ForgotPasswordRequestModel] contains the email
  /// [Output] : if operation successful returns [NoParams] returns the ok status
  /// if unsuccessful the response will be [Failure]
  Future<NoParams> forgotPassword(ForgotPasswordRequestModel params);

  /// This method reset the password is to change the user password against his old password
  /// [Input]: [ValidateOtpRequestModel] contains the user old password
  /// [Output] : if operation successful returns [ValidateOtpResponseModel] returns the screen
  /// if unsuccessful the response will be [Failure]
  Future<ValidateOtpResponseModel> validateOtp(ValidateOtpRequestModel params);

  /// This method generates new otp for the specified email
  /// [Input]: [GenerateOtpRequestModel] contains the user old password
  /// [Output] : if operation successful returns [NoParams] returns the just ok status
  /// if unsuccessful the response will be [Failure]
  Future<NoParams> generateOtp(GenerateOtpRequestModel params);
}

class AuthDataSourceImp implements AuthDataSource {
  Dio dio;
  AuthDataSourceImp({required this.dio});

  @override
  Future<RegistrationResponseModel> registerUser(RegistrationRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.registerUrl;
    print(jsonEncode(params));
    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    // print('this is reg $encryptedJson');
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print('this is register response $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '201') {
        return RegistrationResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.message);
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {

        print(exception.response?.data['Text']);
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        Logger().v(decryptedResponse);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        if(jsonResponse['StatusCode']=='400'){
          throw const SomethingWentWrong('User already found');
        }else{
          throw SomethingWentWrong(errorResponseModel.statusMessage);
        }

      }
    }
  }

  @override
  Future<LoginResponseModel> loginUser(LoginRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.loginUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));

    print(jsonEncode(params));
    print('this is the jsonEncode  ${jsonEncode(params)}');
    print('this is the encryptedjson request $encryptedJson');

    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);

      var jsonResponse = jsonDecode(decryptedResponse);
      print('this is the decoded data response dear aftab $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return LoginResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response?.statusCode);
      print(exception.response?.statusMessage);
      Logger().v(exception);
      Logger().v('Here we are dude');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        print(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<LogoutResponseModel> logoutUser(LogoutRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.logoutUrl;
    String encryptedJson = Encryption.encryptObject(jsonEncode(params));

    print(jsonEncode(params));
    print('this is the jsonEncode  ${jsonEncode(params)}');
    print('this is the encryptedjson request $encryptedJson');

    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);

      var jsonResponse = jsonDecode(decryptedResponse);
      print('this is the decoded data response dear aftab $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return LogoutResponseModel.fromJson(jsonResponse);
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      print(exception.response?.statusCode);
      print(exception.response?.statusMessage);

      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonResponse);
        print(jsonResponse);
        throw SomethingWentWrong(errorResponseModel.statusMessage);
      }
    }
  }

  @override
  Future<ResetPasswordResponseModel> resetPassword(ResetPasswordRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.resetUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );
      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);
      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return ResetPasswordResponseModel.fromJson(jsonResponse);
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
  Future<NoParams> forgotPassword(ForgotPasswordRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.forgotPasswordUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));

    print(encryptedJson);

    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      if (response.statusCode == 200) {
        return NoParams();
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
  Future<ValidateOtpResponseModel> validateOtp(ValidateOtpRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.validateOtpUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));

    print({'Text': encryptedJson});

    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      var jsonResponse = jsonDecode(decryptedResponse);

      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['StatusCode'] == '200') {
        return ValidateOtpResponseModel.fromJson(jsonResponse);
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
  Future<NoParams> generateOtp(GenerateOtpRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.generateOtpUrl;

    String encryptedJson = Encryption.encryptObject(jsonEncode(params));
    try {
      final response = await dio.post(
        url,
        data: {'Text': encryptedJson},
      );

      if (response.statusCode == 200) {
        return NoParams();
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
}
