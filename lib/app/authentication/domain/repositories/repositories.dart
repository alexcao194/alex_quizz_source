import '../../../../core/error/failures.dart';
import '../entities/account.dart';

abstract class Repositories {
  const Repositories();
  Future<Failure?> login(String id, String password);
  Future<Failure?> signup(String email, String password, int group, String id);
  Account getAccount();
  String getIP4();
  void setIP4(String ip4);
}