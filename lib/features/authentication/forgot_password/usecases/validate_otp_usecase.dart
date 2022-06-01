import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/validate_otp_response_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class ValidateOtpUsecase extends UseCase<ValidateOtpResponseModel, ValidateOtpRequestModel> {
  Repository repository;
  ValidateOtpUsecase(this.repository);

  @override
  Future<Either<Failure, ValidateOtpResponseModel>> call(ValidateOtpRequestModel params) async {
    return await repository.validateOtp(params);
  }
}
