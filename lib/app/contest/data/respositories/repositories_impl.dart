import 'package:alex_quizz/app/core/data/datasources/cache_data.dart';
import 'package:alex_quizz/core/error/failures.dart';
import 'package:alex_quizz/core/extension/string_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../contest/data/datasources/remote_data.dart';
import '../../../contest/domain/repositories/repositories.dart';

class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.coreCacheData});
  final RemoteData remoteData;
  final CoreCacheData coreCacheData;

  @override
  Future<Either<Failure, List>> get() async {
    try {
      return Right(await remoteData.get(coreCacheData.getIP4(), coreCacheData.getToken().token));
    } on DioError catch(e) {
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption()));
    }
  }

  @override
  Future<Failure?> submit(int test, List<String> answers) async {
    try {
      await remoteData.submit(coreCacheData.getIP4(), coreCacheData.getToken().token, test, answers);
    } on DioError catch(e) {
      return Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption());
    }
    return null;
  }
  @override
  Future<Either<Failure, Map<String, int>>> getInfo() async {
    try {
      return Right(await remoteData.getInfo(coreCacheData.getIP4(), coreCacheData.getToken().token));
    } on DioError catch(e) {
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption()));
    }
  }
}