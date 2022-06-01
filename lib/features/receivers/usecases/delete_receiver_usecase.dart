import 'package:dartz/dartz.dart';
import 'package:uremit/features/receivers/models/delete_receiver_response_model.dart';
import 'package:uremit/features/receivers/models/delete_receiver_request_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';


class DeleteReceiverUsecase extends UseCase<DeleteReceiverResponseModel, DeleteReceiverRequestModel> {
  Repository repository;

  DeleteReceiverUsecase(this.repository);

  @override
  Future<Either<Failure, DeleteReceiverResponseModel>> call(DeleteReceiverRequestModel params) async {
    return await repository.deleteReceiver(params);
  }
}
