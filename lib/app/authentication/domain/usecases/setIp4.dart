import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/user.dart';
import '../repositories/repositories.dart';

class SetIP4 {
  const SetIP4({required this.repositories});
  final Repositories repositories;

  void call(String ip) async {
    repositories.setIP4(ip);
  }
}