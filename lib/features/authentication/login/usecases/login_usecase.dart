import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/login/models/login_request_model.dart';
import 'package:uremit/features/authentication/login/models/login_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/repository/repository.dart';
import 'package:uremit/services/usecase/usecase.dart';

class LoginUsecase extends UseCase<LoginResponseModel, LoginRequestModel> {
  Repository repository;
  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginRequestModel params) async {
    return await repository.loginUser(params);
  }
}
