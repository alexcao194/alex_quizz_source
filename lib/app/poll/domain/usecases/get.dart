import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/repositories.dart';

class Get {
  const Get({required this.repositories});
  final Repositories repositories;
  Future<Either<Failure, List<String>>> call() async {
    return await repositories.get();
  }
}