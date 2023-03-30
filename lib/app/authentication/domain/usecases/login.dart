import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/user.dart';
import '../repositories/repositories.dart';

class Login {
  const Login({required this.repositories});
  final Repositories repositories;

  Future<Failure?> call(Account account) async {
    if(account.id.isEmpty) {
      return const Failure(message: 'Email is empty');
    }
    if(account.password.isEmpty) {
      return const Failure(message: 'Password is empty');
    }
    return await repositories.login(account.id, account.password);
  }
}