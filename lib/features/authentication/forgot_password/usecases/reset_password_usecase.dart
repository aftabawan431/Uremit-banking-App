import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_request_model.dart';
import 'package:uremit/features/authentication/forgot_password/models/reset_password_response_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class ResetPasswordUsecase extends UseCase<ResetPasswordResponseModel, ResetPasswordRequestModel> {
  Repository repository;
  ResetPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordResponseModel>> call(ResetPasswordRequestModel params) async {
    return await repository.resetPassword(params);
  }
}
