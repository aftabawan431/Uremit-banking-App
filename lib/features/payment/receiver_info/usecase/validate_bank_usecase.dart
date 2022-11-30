import 'package:dartz/dartz.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/repository/repository.dart';
import '../../../receivers/models/validate_bank_request_model.dart';
import '../../../receivers/models/validate_bank_response_model.dart';

class ValidateBankUsecase extends UseCase<ValidateBankResponseModel, ValidateBankRequestModel> {
  Repository repository;
  ValidateBankUsecase(this.repository);

  @override
  Future<Either<Failure, ValidateBankResponseModel>> call(ValidateBankRequestModel params) async {
    return await repository.validateBank(params);
  }
}
