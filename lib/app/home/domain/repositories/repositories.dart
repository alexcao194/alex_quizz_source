import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_info.dart';

abstract class Repositories {
  const Repositories();
  Future<Either<Failure, UserInfoEntity>> getUserInfo();
}