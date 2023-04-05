import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class Repositories {
  const Repositories();
  Future<Either<Failure, List<dynamic>>> get();
  Future<Failure?> submit(int test, List<String> answers);
  Future<Either<Failure, Map<String, int>>> getInfo();
}