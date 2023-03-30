import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/user.dart';
import '../repositories/repositories.dart';

class GetIP4 {
  const GetIP4({required this.repositories});
  final Repositories repositories;

  String call() {
    return repositories.getIP4();
  }
}