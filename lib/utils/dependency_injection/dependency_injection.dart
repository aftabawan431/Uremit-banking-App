import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uremit/app/providers/account_provider.dart';
import 'package:uremit/app/providers/date_time_provider.dart';
import 'package:uremit/app/usecases/profile_header_usecase.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/manager/auth_wrapper_view_model.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/manager/forgot_password_view_model.dart';
import 'package:uremit/features/authentication/forgot_password/usecases/forgot_password_usecase.dart';
import 'package:uremit/features/authentication/login/presentation/manager/login_view_model.dart';
import 'package:uremit/features/authentication/login/usecases/login_usecase.dart';
import 'package:uremit/features/authentication/login/usecases/logout_usecase.dart';
import 'package:uremit/features/authentication/otp/presentation/manager/otp_view_model.dart';
import 'package:uremit/features/authentication/otp/usecases/generate_otp_usecase.dart';
import 'package:uremit/features/authentication/rates/presentation/manager/rates_view_model.dart';
import 'package:uremit/features/authentication/rates/usecases/get_rate_list_usecase.dart';
import 'package:uremit/features/authentication/registration/presentation/manager/registration_view_model.dart';
import 'package:uremit/features/authentication/registration/usecases/registration_usecase.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/features/cards/usecases/delete_card_usecase.dart';
import 'package:uremit/features/dashboard/usecases/get_promotion_list_usecase.dart';
import 'package:uremit/features/dashboard/usecases/get_transaction_list_usecase.dart';
import 'package:uremit/features/files/files_wrapper/presentation/manager/files_wrapper_view_model.dart';
import 'package:uremit/features/files/previous_files/presentation/manager/previous_files_view_model.dart';
import 'package:uremit/features/files/required_files/presentation/manager/required_file_view_model.dart';
import 'package:uremit/features/files/required_files/usecases/get_required_file_usecase.dart';
import 'package:uremit/features/home/usecases/profile_image_usecase.dart';
import 'package:uremit/features/menu/documents/presentation/manager/documents_view_model.dart';
import 'package:uremit/features/menu/documents/usecases/required_document_usecase.dart';
import 'package:uremit/features/menu/profile/presentation/manager/profile_view_model.dart';
import 'package:uremit/features/menu/profile/usecases/get_profile_details_usecase.dart';
import 'package:uremit/features/menu/security/presentation/manager/security_view_model.dart';
import 'package:uremit/features/menu/security/usecases/change_password_usecase.dart';
import 'package:uremit/features/menu/update_profile/usecases/countries_province_usecase.dart';
import 'package:uremit/features/menu/update_profile/usecases/doc_type_usecase.dart';
import 'package:uremit/features/menu/update_profile/usecases/get_countries_usecase.dart';
import 'package:uremit/features/payment/pay_id/use_cases/insert_payment_proof_usecase.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/usecases/getPaymentMethodsResponseUsecase.dart';
import 'package:uremit/features/payment/receipt_screen/usecases/insert_payment_usecase.dart';
import 'package:uremit/features/receivers/usecases/receiver_list_usecase.dart';

import '../../app/globals.dart';
import '../../features/authentication/forgot_password/usecases/reset_password_usecase.dart';
import '../../features/authentication/forgot_password/usecases/validate_otp_usecase.dart';
import '../../features/cards/usecases/get_all_cards_usecase.dart';
import '../../features/dashboard/presentation/manager/dashboard_view_model.dart';
import '../../features/files/previous_files/usecases/get_previous_file_usecase.dart';
import '../../features/home/presentation/manager/home_view_model.dart';
import '../../features/menu/account_wrapper/presentation/manager/account_wrapper_view_model.dart';
import '../../features/menu/update_profile/presentation/manager/update_profile_view_model.dart';
import '../../features/payment/credit_card_payment/presentation/manager/credit_card_payment_view_model.dart';
import '../../features/payment/pay_id/presentation/manager/pay_id_view_model.dart';
import '../../features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import '../../features/payment/payment_details/usecase/get_payment_rate_list_usecase.dart';
import '../../features/payment/payment_wrapper/presentation/manager/payment_wrapper_view_model.dart';
import '../../features/payment/personal_info/presentation/manager/personal_info_view_model.dart';
import '../../features/payment/personal_info/usecase/set_profile_details_usecase.dart';
import '../../features/payment/poli_payment/presentation/manager/poli_payment_view_model.dart';
import '../../features/payment/receipt_screen/usecases/getPaymentMethodsResponseUsecase.dart';
import '../../features/payment/receiver_info/presentation/manager/receiver_info_view_model.dart';
import '../../features/payment/receiver_info/usecase/receiver_add_usecase.dart';
import '../../features/receivers/presentation/manager/receiver_view_model.dart';
import '../../features/receivers/usecases/add_receiver_bank_usecase.dart';
import '../../features/receivers/usecases/delete_receiver_bank_usecase.dart';
import '../../features/receivers/usecases/delete_receiver_usecase.dart';
import '../../features/receivers/usecases/get_bank_list_usecase.dart';
import '../../features/receivers/usecases/update_receiver_nickname_usecase.dart';
import '../../features/splash/presentation/manager/splash_view_model.dart';
import '../../services/repository/repository.dart';
import '../../services/repository/repository_imp.dart';
import '../data_sources/auth_data_source.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../network/network_info.dart';
import '../router/app_state.dart';

Future<void> init() async {
  /// UseCases
  sl.registerLazySingleton(() => RegistrationUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));
  sl.registerLazySingleton(() => ValidateOtpUsecase(sl()));
  sl.registerLazySingleton(() => GetRateListUsecase(sl()));
  sl.registerLazySingleton(() => GetCountriesUsecase(sl()));
  sl.registerLazySingleton(() => GenerateOtpUsecase(sl()));
  sl.registerLazySingleton(() => GetAllCardsUsecase(sl()));
  sl.registerLazySingleton(() => GetPromotionListUsecase(sl()));
  sl.registerLazySingleton(() => GetTransactionListUsecase(sl()));
  sl.registerLazySingleton(() => ReceiverListUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCardUsecase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetProfileDetailsUsecase(sl()));
  sl.registerLazySingleton(() => GetRequiredFileUsecase(sl()));
  sl.registerLazySingleton(() => ProfileHeaderUsecase(sl()));
  sl.registerLazySingleton(() => GetPreviousFileUsecase(sl()));
  sl.registerLazySingleton(() => SetProfileDetailsUsecase(sl()));
  sl.registerLazySingleton(() => ProfileImageUsecase(sl()));
  sl.registerLazySingleton(() => AddReceiverBankListUsecase(sl()));
  sl.registerLazySingleton(() => DeleteReceiverBankListUsecase(sl()));
  sl.registerLazySingleton(() => GetPaymentMethodsReponseUsecase(sl()));
  sl.registerLazySingleton(() => DeleteReceiverUsecase(sl()));
  sl.registerLazySingleton(() => GetBankListUsecase(sl()));

  sl.registerLazySingleton(() => ReceiverAddUsecase(sl()));
  sl.registerLazySingleton(() => UpdateReceiverNicknameUsecase(sl()));
  sl.registerLazySingleton(() => CountriesProvinceUsecase(sl()));
  sl.registerLazySingleton(() => DocTypeUsecase(sl()));
  sl.registerLazySingleton(() => GetPaymentRateListUsecase(sl()));
  sl.registerLazySingleton(() => RequiredDocumentUsecase(sl()));
  sl.registerLazySingleton(() => InsertPaymentProofUsecase(sl()));

  sl.registerLazySingleton(() => InsertPaymentUsecase(sl()));

  /// Configs
  sl.registerLazySingleton(() => AccountProvider());
  sl.registerLazySingleton(() => DateTimeProvider());

  /// Data Sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImp(dio: sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImp(flutterSecureStorage: sl()));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(dio: sl()));

  /// Repository
  sl.registerLazySingleton<Repository>(() => RepositoryImp(networkInfo: sl(), authDataSource: sl(), localDataSource: sl(), remoteDataSource: sl()));

  /// External
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => DeviceInfoPlugin());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// View Models
  sl.registerLazySingleton(() => SplashViewModel(deviceInfo: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => AuthWrapperViewModel());
  sl.registerLazySingleton(() => LoginViewModel(sl(), sl()));
  sl.registerLazySingleton(() => RegistrationViewModel(sl()));
  sl.registerLazySingleton(() => OtpViewModel(validateOtpUsecase: sl(), generateOtpUsecase: sl()));
  sl.registerLazySingleton(() => ForgotPasswordViewModel(generateOtpUsecase: sl(), validateOtpUsecase: sl(), forgotPasswordUsecase: sl(), resetPasswordUsecase: sl()));
  sl.registerLazySingleton(() => HomeViewModel(profileHeaderUsecase: sl(), profileImageUsecase: sl()));
  sl.registerLazySingleton(() => DashboardViewModel(getPromotionListUsecase: sl(), getTransactionListUsecase: sl()));
  sl.registerLazySingleton(() => ReceiverViewModel(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => CardsViewModel(getAllCardsUsecase: sl(), deleteCardUsecase: sl()));
  sl.registerLazySingleton(() => RatesViewModel(sl()));
  sl.registerLazySingleton(() => AccountWrapperViewModel());
  sl.registerLazySingleton(() => ProfileViewModel(sl()));
  sl.registerLazySingleton(() => UpdateProfileViewModel(getCountriesUsecase: sl(), countriesProvinceUsecase: sl(), docTypeUsecase: sl(), setProfileDetailsUsecase: sl()));
  sl.registerFactory(() => SecurityViewModel(sl()));
  sl.registerLazySingleton(() => DocumentsViewModel(docTypeUsecase: sl(), getCountriesUsecase: sl(), requiredDocumentUsecase: sl()));
  sl.registerLazySingleton(() => FilesWrapperViewModel());
  sl.registerLazySingleton(() => PreviousFilesViewModel(sl()));
  sl.registerLazySingleton(() => RequiredFilesViewModel(sl()));
  sl.registerLazySingleton(() => PayIdInfoViewModel(sl()));
  sl.registerLazySingleton(() => PaymentWrapperViewModel());
  sl.registerLazySingleton(() => PaymentDetailsViewModel(getPaymentRateListUsecase: sl()));
  sl.registerLazySingleton(() => ReceiverInfoViewModel(getCountriesUsecase: sl(), getBankListUsecase: sl(), receiverAddUsecase: sl()));
  sl.registerLazySingleton(() => PoliPaymentViewModel());
  sl.registerLazySingleton(() => CreditCardPaymentViewModel());

  sl.registerLazySingleton(() => ReceiptScreenViewModel(getPaymentMethodsReponseUsecase: sl(), insertPaymentUsecase: sl()));

  sl.registerLazySingleton(() => ProfileInfoViewModel(docTypeUsecase: sl(), countriesProvinceUsecase: sl(), getCountriesUsecase: sl(), setProfileDetailsUsecase: sl()));

  /// Navigator
  sl.registerLazySingleton(() => AppState());
}
