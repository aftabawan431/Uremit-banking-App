import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/otp/models/generate_otp_request_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/models/no_params.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class GenerateOtpUsecase extends UseCase<NoParams, GenerateOtpRequestModel> {
  Repository repository;
  GenerateOtpUsecase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(GenerateOtpRequestModel params) async {
    return await repository.generateOtp(params);
  }
}
