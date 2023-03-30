
import 'dart:convert';

import 'package:alex_quizz/app/home/data/models/user_info.dart';
import 'package:dio/dio.dart';

abstract class RemoteData {
  const RemoteData();
  Future<UserInfoModal> getInfo(String token, String ip);
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;

  @override
  Future<UserInfoModal> getInfo(String token, String ip) async {
    var res = await dio.get('http://$ip/user',
      options: Options(
        headers: {
          'x-access-token' : token
        }
      )
    );
    return UserInfoModal.fromJson(res.data);
  }
}