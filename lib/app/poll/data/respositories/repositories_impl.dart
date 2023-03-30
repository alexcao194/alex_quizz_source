import 'package:alex_quizz/core/error/failures.dart';
import 'package:alex_quizz/core/extension/string_extension.dart';
import 'package:dio/dio.dart';

import 'package:dartz/dartz.dart';

import '../../../core/data/datasources/cache_data.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/remote_data.dart';

class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.coreCacheData});
  final RemoteData remoteData;
  final CoreCacheData coreCacheData;
  @override
  Future<Either<Failure, List<String>>> get() async {
    try {
      return Right(await remoteData.get(coreCacheData.getIP4(), coreCacheData.getToken().token));
    } on DioError catch(e) {
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption()));
    }
  }

  @override
  Future<Failure?> submit(List<String> answers) {
    // TODO: implement submit
    throw UnimplementedError();
  }
}