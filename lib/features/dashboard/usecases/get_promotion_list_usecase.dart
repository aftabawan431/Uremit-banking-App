import 'package:dartz/dartz.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_request_model.dart';
import 'package:uremit/features/dashboard/models/get_promotion_list_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/repository/repository.dart';
import 'package:uremit/services/usecase/usecase.dart';

class GetPromotionListUsecase extends UseCase<GetPromotionListResponseModel, GetPromotionListRequestModel> {
  Repository repository;

  GetPromotionListUsecase(this.repository);

  @override
  Future<Either<Failure, GetPromotionListResponseModel>> call(GetPromotionListRequestModel params) async {
    return await repository.getPromotionList(params);
  }
}
