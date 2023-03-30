import 'package:alex_quizz/app/authentication/data/models/account.dart';
import 'package:alex_quizz/app/core/data/datasources/cache_data.dart';
import 'package:alex_quizz/core/extension/string_extension.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/cache_data.dart';
import '../datasources/remote_data.dart';


class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.cacheData, required this.coreCacheData});
  final RemoteData remoteData;
  final CacheData cacheData;
  final CoreCacheData coreCacheData;

  @override
  Future<Failure?> login(String id, String password) async {
    cacheData.cacheAccount(AccountModal(id: id, password: password));
    try {
      var token = await remoteData.login(id, password, coreCacheData.getIP4());
      if(token != null) {
        coreCacheData.cacheToken(token);
      }
    } on DioError catch (e) {
      return Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption());
    }
    return null;
  }

  @override
  Future<Failure?> signup(String email, String password, int group, String id) async {
    try {
      await remoteData.signup(email, password, group, id, coreCacheData.getIP4());
      cacheData.cacheAccount(AccountModal(id: id, password: password));
    } on DioError catch (e) {
      return Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption());
    }
    return null;
  }

  @override
  Account getAccount() {
    return cacheData.getAccount();
  }

  @override
  String getIP4() {
    return coreCacheData.getIP4();
  }

  @override
  void setIP4(String ip) {
    coreCacheData.setIP4(ip);
  }

}