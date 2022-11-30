
import 'package:dartz/dartz.dart';

import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';
import '../models/get_required_file_response_model.dart';
import '../models/get_required_files_request_model.dart';

class GetRequiredFileUsecase extends UseCase<GetRequiredFileResponseModel, GetRequiredFileRequestModel> {
  Repository repository;
  GetRequiredFileUsecase(this.repository);
  @override
  Future<Either<Failure, GetRequiredFileResponseModel>> call(GetRequiredFileRequestModel params) async {
    return await repository.getRequiredFiles(params);
  }
}