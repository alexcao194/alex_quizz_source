import 'package:alex_quizz/core/error/failures.dart';

import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetInfo {
  const GetInfo({required this.repositories});
  final Repositories repositories;

  Future<Either<Failure, Map<String, int>>> call() async {
    return await repositories.getInfo();
  }
}