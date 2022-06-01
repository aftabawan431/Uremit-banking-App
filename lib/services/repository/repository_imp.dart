import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:uremit/app/models/profile_header_request_model.dart';
import 'package:uremit/app/models/profile_header_response_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/forgot_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_response_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_response_model.dart';
import 'package:uremit/features/authentication/login/models/login_request_model.dart';
import 'package:uremit/features/authentication/login/models/login_response_model.dart';
import 'package:uremit/features/authentication/login/models/logout_request_model.dart';
import 'package:uremit/features/authentication/login/models/logout_response_model.dart';
import 'package:uremit/features/authentication/otp/models/generate_otp_request_model.dart';
import 'package:uremit/features/authentication/rates/models/get_rate_list_response_model.dart';
import 'package:uremit/features/authentication/registration/models/registration_request_model.dart';
import 'package:uremit/features/authentication/registration/models/registration_response_model.dart';
import 'package:uremit/features/cards/models/delete_card_request_model.dart';
import 'package:uremit/features/cards/models/delete_card_response_model.dart';
import 'package:uremit/features/cards/models/get_all_cards_request_model.dart';
import 'package:uremit/features/cards/models/get_all_cards_response_model.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_request_model.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_response_model.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_request_model.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';
import 'package:uremit/features/files/required_files/models/get_required_file_response_model.dart';
import 'package:uremit/features/files/required_files/models/get_required_files_request_model.dart';
import 'package:uremit/features/home/models/profile_image_request_model.dart';
import 'package:uremit/features/home/models/profile_image_response_model.dart';
import 'package:uremit/features/menu/documents/models/doc_requied_request_model.dart';
import 'package:uremit/features/menu/documents/models/document_required_response_model.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_request_model.dart';
import 'package:uremit/features/menu/profile/models/get_profile_details_response_model.dart';
import 'package:uremit/features/menu/security/models/change_password_request_model.dart';
import 'package:uremit/features/menu/security/models/change_password_response_model.dart';
import 'package:uremit/features/menu/update_profile/models/countries_province_request_model.dart';
import 'package:uremit/features/menu/update_profile/models/countries_province_response_model.dart';
import 'package:uremit/features/menu/update_profile/models/doc_type_request_model.dart';
import 'package:uremit/features/menu/update_profile/models/doc_type_response_model.dart';
import 'package:uremit/features/menu/update_profile/models/get_countries_response_model.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_proof_response_modal.dart';
import 'package:uremit/features/payment/pay_id/modal/insert_payment_response_request_modal.dart';
import 'package:uremit/features/payment/personal_info/models/set_profile_details_request_model.dart';
import 'package:uremit/features/payment/receipt_screen/modal/getPaymentMethodResponseModal.dart';
import 'package:uremit/features/payment/receipt_screen/modal/insert_payment_transfer_request_model.dart';
import 'package:uremit/features/payment/receiver_info/models/receiver_add_request_list_model.dart';
import 'package:uremit/features/receivers/models/add_receiver_bank_request_model.dart';
import 'package:uremit/features/receivers/models/add_receiver_bank_response_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_bank_request_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_bank_response_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_request_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_response_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_request_model.dart';
import 'package:uremit/features/receivers/models/get_bank_list_response_model.dart';
import 'package:uremit/features/receivers/models/receiver_list_request_model.dart';
import 'package:uremit/features/receivers/models/receiver_list_response_model.dart';
import 'package:uremit/features/receivers/models/update_receiver_nickname_request_model.dart';
import 'package:uremit/features/receivers/models/update_receiver_nickname_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/models/no_params.dart';
import 'package:uremit/utils/constants/app_level/app_messages.dart';

import '../../features/files/previous_files/models/get_previous_file_response_model.dart';
import '../../features/files/previous_files/models/get_previous_files_request_model.dart';
import '../../features/payment/payment_details/models/get_rate_lists_response_model.dart';
import '../../features/payment/receipt_screen/modal/insert_payment_response_modal.dart';
import '../../features/payment/receiver_info/models/receiver_add_request_list_model.dart';
import '../../features/payment/receiver_info/models/receiver_add_response_list_model.dart';
import '../../utils/data_sources/auth_data_source.dart';
import '../../utils/data_sources/local_data_source.dart';
import '../../utils/data_sources/remote_data_source.dart';
import '../../utils/network/network_info.dart';
import 'repository.dart';

class RepositoryImp extends Repository {
  final NetworkInfo networkInfo;
  final AuthDataSource authDataSource;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  RepositoryImp({
    required this.networkInfo,
    required this.authDataSource,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, RegistrationResponseModel>> registerUser(RegistrationRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await authDataSource.registerUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    print('here');
    try {
      return Right(await authDataSource.loginUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, LogoutResponseModel>> logoutUser(LogoutRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    print('here');
    try {
      return Right(await authDataSource.logoutUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  Future<Either<Failure, DocumentRequiredResponseModel>> docRequired(DocumentRequiredRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    print('here');
    try {
      return Right(await remoteDataSource.documentRequired(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponseModel>> resetPassword(ResetPasswordRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await authDataSource.resetPassword(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> forgotPassword(ForgotPasswordRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await authDataSource.forgotPassword(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ValidateOtpResponseModel>> validateOtp(ValidateOtpRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await authDataSource.validateOtp(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetCountriesResponseModel>> getCountries(NoParams params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getCountries(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetRateListResponseModel>> getShortRateList(NoParams params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getShortRateList(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetPaymentRateListResponseModal>> getRateLists(NoParams params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getRateLists(params));
    } on Failure catch (e) {
      Logger().i(e);
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> generateOtp(GenerateOtpRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await authDataSource.generateOtp(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetAllCardsResponseModel>> getAllCards(GetAllCardsRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getAllCards(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, DeleteCardResponseModel>> deleteCard(DeleteCardRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.deleteCard(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ChangePasswordResponseModel>> changePassword(ChangePasswordRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.changePassword(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetProfileDetailsResponseModel>> getProfileDetails(GetProfileDetailsRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getProfileDetails(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProfileHeaderResponseModel>> profileHeader(ProfileHeaderRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.profileHeader(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetPromotionListResponseModel>> getPromotionList(GetPromotionListRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getPromotionList(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetPreviousFileResponseModel>> getPreviousFiles(GetPreviousFilesRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getPreviousFiles(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetProfileDetailsResponseModel>> setProfileDetails(SetProfileDetailsRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      print('here 3');
      return Right(await remoteDataSource.setProfileDetails(params));
    } on Failure catch (e) {
      print('this is the message ${e.message}');
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ReceiverListResponseModel>> receiverList(ReceiverListRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.receiverList(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProfileImageResponseModel>> profileImage(ProfileImageRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.profileImage(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, AddReceiverBankResponseModel>> addReceiverBank(AddReceiverBankRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.addReceiverBank(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, DeleteReceiverResponseModel>> deleteReceiver(DeleteReceiverRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.deleteReceiver(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, DeleteReceiverBankListResponseModel>> deleteReceiverBank(DeleteReceiverBankListRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.deleteReceiverBank(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetBankListResponseModel>> getBankList(GetBankListRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getBankList(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, ReceiverAddResponseListModel>> receiverAdd(ReceiverAddRequestListModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.receiverAdd(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, UpdateReceiverNicknameResponseModel>> updateReceiverNickname(UpdateReceiverNicknameRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.updateReceiverNickname(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetRequiredFileResponseModel>> getRequiredFiles(GetRequiredFileRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getRequiredFile(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, CountriesProvinceResponseModel>> getCountryProvinces(CountriesProvinceRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getCountryProvinces(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, DocTypeResponseModel>> getDocTypes(DocTypeRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getDocTypes(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, InsertPaymentTransferResponseModal>> insertPaymentTransfer(InsertPaymentTransferRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.insertPaymentTransfer(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetPaymentMethodResponseModal>> getPaymentMethods(NoParams params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getPaymentMethods(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, InsertPaymentProofResponseModal>> insertPaymentProof(InsertPaymentProofRequestModal params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.insertPaymentProof(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  Future<Either<Failure, DocumentRequiredResponseModel>> documentRequired(DocumentRequiredRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.documentRequired(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetTransactionListResponseModel>> getTransactionList(GetTransactionListRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getTransactionList(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}
