import 'package:alex_quizz/app/quiz/domain/entities/quiz_result.dart';
import 'package:alex_quizz/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class GetQuizResult {
  const GetQuizResult({required this.repositories});
  final Repositories repositories;

  Future<Either<Failure, QuizResult>> call() async {
    return await repositories.getQuizResult();
  }
}