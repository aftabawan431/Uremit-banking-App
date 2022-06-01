import 'package:dartz/dartz.dart';
import 'package:uremit/features/receivers/models/receiver_list_request_model.dart';
import 'package:uremit/features/receivers/models/receiver_list_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';

class ReceiverListUsecase extends UseCase<ReceiverListResponseModel, ReceiverListRequestModel> {
  Repository repository;

  ReceiverListUsecase(this.repository);

  @override
  Future<Either<Failure, ReceiverListResponseModel>> call(ReceiverListRequestModel params) async {
    return await repository.receiverList(params);
  }
}
