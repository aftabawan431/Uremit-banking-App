import 'package:dartz/dartz.dart';
import 'package:uremit/features/receivers/models/payment_header_request_model.dart';
import 'package:uremit/features/receivers/models/payment_header_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/usecase/usecase.dart';

import '../../../services/repository/repository.dart';

class PaymentHeaderUsecase extends UseCase<PaymentHeaderResponseModel, PaymentHeaderRequestModel> {
  Repository repository;

  PaymentHeaderUsecase(this.repository);

  @override
  Future<Either<Failure, PaymentHeaderResponseModel>> call(PaymentHeaderRequestModel params) async {
    return await repository.getPaymentHeaderDetails(params);
  }
}
