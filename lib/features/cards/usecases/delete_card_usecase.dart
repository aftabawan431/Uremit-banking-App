import 'package:dartz/dartz.dart';
import 'package:uremit/features/cards/models/delete_card_request_model.dart';
import 'package:uremit/features/cards/models/delete_card_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';

class DeleteCardUsecase extends UseCase<DeleteCardResponseModel, DeleteCardRequestModel> {
  Repository repository;

  DeleteCardUsecase(this.repository);

  @override
  Future<Either<Failure, DeleteCardResponseModel>> call(DeleteCardRequestModel params) async {
    return await repository.deleteCard(params);
  }
}
