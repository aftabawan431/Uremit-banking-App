import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class InstantUseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}
