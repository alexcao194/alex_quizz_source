import 'package:alex_quizz/core/extension/string_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../core/data/datasources/cache_data.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/remote_data.dart';

class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.coreCacheData});

  final CoreCacheData coreCacheData;
  final RemoteData remoteData;

  @override
  Future<Either<Failure, List<Quiz>>> getQuiz() async {
    try {
      return Right(await remoteData.getQuiz(coreCacheData.getToken().token, coreCacheData.getIP4()));
    } on DioError catch(e) {
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption()));
    }
  }

  @override
  Future<Either<Failure, QuizResult>> getQuizResult() async {
    try {
      return Right(await remoteData.getResult(coreCacheData.getToken().token, coreCacheData.getIP4()));
    } on DioError catch(e) {
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption()));
    }
  }

  @override
  Future<Either<Failure, bool>> submitQuiz(String answer) async {
    try {
      return Right(await remoteData.submitQuiz(coreCacheData.getToken().token, coreCacheData.getIP4(), answer));
    } on DioError catch(e) {
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption()));
    }
  }
}