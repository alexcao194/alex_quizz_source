import 'package:alex_quizz/core/extension/string_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../core/data/datasources/cache_data.dart';
import '../../domain/entities/user_info.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/remote_data.dart';

class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.coreCacheData});
  final RemoteData remoteData;
  final CoreCacheData coreCacheData;

  @override
  Future<Either<Failure, UserInfoEntity>> getUserInfo() async {
    try {
      return Right(await remoteData.getInfo(coreCacheData.getToken().token, coreCacheData.getIP4()));
    } on DioError catch(e) {
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption()));
    }
  }
}