import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/data/models/token.dart';
abstract class RemoteData {
  const RemoteData();
  Future<void> signup(String email, String password, int group, String id, String ip);
  Future<TokenModal?> login(String id, String password, String ip);
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;

  @override
  Future<TokenModal?> login(String id, String password, String ip) async {
    var res = await dio.post('http://$ip/login',
        options: Options(
            contentType: 'application/json'
        ),
        data: {
          "id" : id,
          "password" : password,
        }
    ).timeout(const Duration(milliseconds: 3000),
        onTimeout: () {
          throw DioError(requestOptions: RequestOptions(path: 'get'), error: 'network error, path : $ip');
        }
    );
    var message = res.data['message'].toString();
    if(message != 'login-successful') {
      throw DioError(requestOptions: RequestOptions(path: 'get'), error: message);
    }
    var accessToken = res.data['accessToken'];
    var refreshToken = res.data['refreshToken'];
    if(accessToken != null && refreshToken != null) {
      return TokenModal(token: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  @override
  Future<void> signup(String email, String password, int group, String id, String ip) async {
    var res = await dio.post('http://$ip/signup',
        options: Options(
            contentType: 'application/json'
        ),
        data: json.encode({
          "id" : id,
          "password" : password,
          "email" : email,
          "group" : group
        })
    ).timeout(const Duration(milliseconds: 3000),
      onTimeout: () {
        throw DioError(requestOptions: RequestOptions(path: 'post'), error: 'network error, path : $ip');
      }
    );
    var message = res.data['message'].toString();
    if(message != 'signup-successful') {
      throw DioError(requestOptions: RequestOptions(path: 'post'), error: message);
    }
  }
  
}