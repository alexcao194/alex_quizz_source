import 'package:alex_quizz/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../contest/domain/repositories/repositories.dart';

class Get {
  const Get({required this.repositories});
  final Repositories repositories;
  Future<Either<Failure, List<dynamic>>> call() async {
    return repositories.get();
  }
}