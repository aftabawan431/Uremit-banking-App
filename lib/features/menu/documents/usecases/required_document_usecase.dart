import 'package:dartz/dartz.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/repository/repository.dart';
import '../models/doc_requied_request_model.dart';
import '../models/document_required_response_model.dart';

class RequiredDocumentUsecase extends UseCase<DocumentRequiredResponseModel, DocumentRequiredRequestModel> {
  Repository repository;

  RequiredDocumentUsecase(this.repository);

  @override
  Future<Either<Failure, DocumentRequiredResponseModel>> call(DocumentRequiredRequestModel params) async {
    return await repository.documentRequired(params);
  }
}
