import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/repositories.dart';

class Signup {
  const Signup({required this.repositories});
  final Repositories repositories;

  Future<Failure?> call(Account account, int group, String email) async {
    if(email.isEmpty) {
      return const Failure(message: 'Email is empty');
    }
    if(account.password != account.rePassword) {
      return const Failure(message: 'Password is not match');
    }
    if(account.password.isEmpty) {
      return const Failure(message: 'Password is empty');
    }
    if(group == 0) {
      return const Failure(message: 'Invalid group');
    }
   return await repositories.signup(email.toLowerCase(), account.password.toUpperCase(), group, account.id.toUpperCase());
  }
}
