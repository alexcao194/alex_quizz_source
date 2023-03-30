import '../../../../core/error/failures.dart';
import '../repositories/repositories.dart';

class Submit {
  const Submit({required this.repositories});
  final Repositories repositories;
  Future<Failure?> call(List<String> answers) async {
    return await repositories.submit(answers);
  }
}