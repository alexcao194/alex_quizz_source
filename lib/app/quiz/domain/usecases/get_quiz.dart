import 'package:alex_quizz/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/quiz.dart';
import '../repositories/repositories.dart';

class GetQuiz {
  const GetQuiz({required this.repositories});
  final Repositories repositories;

  Future<Either<Failure, List<Quiz>>> call() async {
    return await repositories.getQuiz();
  }
}