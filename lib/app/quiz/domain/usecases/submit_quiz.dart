import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/repositories.dart';

class SubmitQuiz {
  const SubmitQuiz({required this.repositories});
  final Repositories repositories;
  Future<Either<Failure, bool>> call(String answer) async {
    return await repositories.submitQuiz(answer);
  }
}