import 'package:dartz/dartz.dart';
import 'package:uremit/features/payment/receiver_info/models/receiver_add_request_list_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../../services/repository/repository.dart';
import '../models/receiver_add_response_list_model.dart';

class ReceiverAddUsecase extends UseCase<ReceiverAddResponseListModel, ReceiverAddRequestListModel> {
  Repository repository;
  ReceiverAddUsecase(this.repository);

  @override
  Future<Either<Failure, ReceiverAddResponseListModel>> call(ReceiverAddRequestListModel params) async {
    return await repository.receiverAdd(params);
  }
}
