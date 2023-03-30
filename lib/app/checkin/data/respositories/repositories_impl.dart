import 'dart:io';
import 'package:alex_quizz/app/core/data/datasources/cache_data.dart';
import 'package:alex_quizz/core/extension/string_extension.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/remote_data.dart';


class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.coreCacheData});
  final RemoteData remoteData;
  final CoreCacheData coreCacheData;
  @override
  Future<Failure?> checkIn(String name, File file, String id) async {
    try {
      await remoteData.checkIn(name, file, id, coreCacheData.getIP4());
    } on DioError catch(e) {
      return Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption());
    }
    return null;
  }
}