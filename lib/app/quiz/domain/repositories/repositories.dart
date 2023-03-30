import 'package:alex_quizz/app/quiz/domain/entities/quiz.dart';
import 'package:alex_quizz/app/quiz/domain/entities/quiz_result.dart';
import 'package:alex_quizz/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class Repositories {
  const Repositories();
  Future<Either<Failure, List<Quiz>>> getQuiz();
  Future<Either<Failure, QuizResult>> getQuizResult();
  Future<Either<Failure, bool>> submitQuiz(String answer);
}