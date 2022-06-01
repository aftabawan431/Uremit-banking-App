import 'package:dartz/dartz.dart';
import 'package:uremit/features/menu/security/models/change_password_request_model.dart';
import 'package:uremit/features/menu/security/models/change_password_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/repository/repository.dart';
import 'package:uremit/services/usecase/usecase.dart';

class ChangePasswordUsecase extends UseCase<ChangePasswordResponseModel, ChangePasswordRequestModel> {
  Repository repository;
  ChangePasswordUsecase(this.repository);
  @override
  Future<Either<Failure, ChangePasswordResponseModel>> call(ChangePasswordRequestModel params) async {
    return await repository.changePassword(params);
  }
}
