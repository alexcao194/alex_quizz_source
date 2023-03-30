import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_info.dart';
import '../repositories/repositories.dart';

class GetInfo {
  const GetInfo({required this.repositories});
  final Repositories repositories;
  Future<Either<Failure, UserInfoEntity>> call() async {
    return await repositories.getUserInfo();
  }
}