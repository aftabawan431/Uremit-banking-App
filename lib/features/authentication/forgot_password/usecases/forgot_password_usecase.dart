import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/forgot_password/models/forgot_password_request_model.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/models/no_params.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';

class ForgotPasswordUsecase extends UseCase<NoParams, ForgotPasswordRequestModel> {
  Repository repository;
  ForgotPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(ForgotPasswordRequestModel params) async {
    return await repository.forgotPassword(params);
  }
}
