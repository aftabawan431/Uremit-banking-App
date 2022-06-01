import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/login/models/logout_request_model.dart';
import 'package:uremit/features/authentication/login/models/logout_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/repository/repository.dart';
import 'package:uremit/services/usecase/usecase.dart';

class LogoutUsecase extends UseCase<LogoutResponseModel, LogoutRequestModel> {
  Repository repository;
  LogoutUsecase(this.repository);

  @override
  Future<Either<Failure, LogoutResponseModel>> call(LogoutRequestModel params) async {
    return await repository.logoutUser(params);
  }
}
