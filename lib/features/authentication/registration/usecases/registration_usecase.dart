import 'package:dartz/dartz.dart';
import 'package:uremit/features/authentication/registration/models/registration_request_model.dart';
import 'package:uremit/features/authentication/registration/models/registration_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/repository/repository.dart';
import 'package:uremit/services/usecase/usecase.dart';

class RegistrationUsecase extends UseCase<RegistrationResponseModel, RegistrationRequestModel> {

  Repository repository;
  RegistrationUsecase(this.repository);

  @override
  Future<Either<Failure, RegistrationResponseModel>> call(RegistrationRequestModel params) async {
    return await repository.registerUser(params);
  }

}