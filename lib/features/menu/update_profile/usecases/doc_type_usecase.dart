import 'package:dartz/dartz.dart';
import 'package:uremit/features/menu/update_profile/models/doc_type_request_model.dart';
import 'package:uremit/features/menu/update_profile/models/doc_type_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/repository/repository.dart';

class DocTypeUsecase extends UseCase<DocTypeResponseModel, DocTypeRequestModel> {
  Repository repository;

  DocTypeUsecase(this.repository);

  @override
  Future<Either<Failure, DocTypeResponseModel>> call(DocTypeRequestModel params) async {
    return await repository.getDocTypes(params);
  }
}
