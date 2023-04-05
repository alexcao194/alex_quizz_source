import '../../../../core/error/failures.dart';
import '../../../contest/domain/repositories/repositories.dart';

class Submit {
  const Submit({required this.repositories});
  final Repositories repositories;
  Future<Failure?> call(int test, List<String> answers) async {
    return await repositories.submit(test, answers);
  }
}