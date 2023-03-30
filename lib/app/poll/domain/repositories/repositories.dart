import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class Repositories {
  const Repositories();
  Future<Either<Failure, List<String>>> get();
  Future<Failure?> submit(List<String> answers);
}