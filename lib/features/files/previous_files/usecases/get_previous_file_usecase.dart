import 'package:dartz/dartz.dart';
import '../../../../services/error/failure.dart';
import '../../../../services/repository/repository.dart';
import '../../../../services/usecase/usecase.dart';
import '../models/get_previous_file_response_model.dart';
import '../models/get_previous_files_request_model.dart';

class GetPreviousFileUsecase extends UseCase<GetPreviousFileResponseModel, GetPreviousFilesRequestModel> {
  Repository repository;
  GetPreviousFileUsecase(this.repository);
  @override
  Future<Either<Failure, GetPreviousFileResponseModel>> call(GetPreviousFilesRequestModel params) async {
    return await repository.getPreviousFiles(params);
  }
}
