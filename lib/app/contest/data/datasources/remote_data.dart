import 'dart:convert';

import 'package:dio/dio.dart';

abstract class RemoteData {
  const RemoteData();
  Future<List<dynamic>> get(String ip, String token);
  Future<void> submit(String ip, String token, int test, List<String> answers);
  Future<Map<String, int>> getInfo(String ip, String token);
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;
  @override
  Future<List> get(String ip, String token) async {
    var response = await dio.get('http://$ip/test',
      options: Options(
        headers: {
          'x-access-token' : token
        }
      )
    );
    return response.data;
  }

  @override
  Future<void> submit(String ip, String token, int test, List<String> answers) async {
    await dio.post('http://$ip/submit-test',
      options: Options(
        headers: {
          'x-access-token' : token
        }
      ),
      queryParameters: {
        'test' : test,
        'result' : answers
      }
    );
  }

  @override
  Future<Map<String, int>> getInfo(String ip, String token) async {
    var response = await dio.get('http://$ip/test-info',
      options: Options(
        headers: {
          'x-access-token' : token
        }
      )
    );
    var info = <String, int>{};
    info['total'] = response.data['total'];
    info['current'] = response.data['current'];
    return info;
  }
}