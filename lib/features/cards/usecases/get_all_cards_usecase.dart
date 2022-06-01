import 'package:dartz/dartz.dart';
import 'package:uremit/features/cards/models/get_all_cards_request_model.dart';
import 'package:uremit/features/cards/models/get_all_cards_response_model.dart';
import 'package:uremit/services/error/failure.dart';
import 'package:uremit/services/repository/repository.dart';
import 'package:uremit/services/usecase/usecase.dart';

class GetAllCardsUsecase extends UseCase<GetAllCardsResponseModel, GetAllCardsRequestModel> {
  Repository repository;

  GetAllCardsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllCardsResponseModel>> call(GetAllCardsRequestModel params) async {
    return await repository.getAllCards(params);
  }
}
