import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/token.dart';
import '../models/token.dart';

abstract class CoreCacheData {
  const CoreCacheData();
  void cacheToken(TokenModal token);
  Token getToken();
  void setIP4(String ip);
  String getIP4();
}

class CoreCacheDataImpl extends CoreCacheData {
  const CoreCacheDataImpl({required this.sharedPreferences});
  final String _tokenKey = 'token-key';
  final String _ipKey = 'ip-key';

  final SharedPreferences sharedPreferences;

  @override
  Token getToken() {
    String? tokenData =  sharedPreferences.getString(_tokenKey);
    if(tokenData == null) {
      return TokenModal(token: '', refreshToken: '');
    }
    var tokenJson = json.decode(tokenData);
    return TokenModal.fromJson(tokenJson);
  }

  @override
  void cacheToken(TokenModal token) async {
    await sharedPreferences.setString(_tokenKey, json.encode(TokenModal.toJson(token)));
  }

  @override
  String getIP4() {
    String? ip = sharedPreferences.getString(_ipKey);
    if(ip == null) {
      return '';
    } else {
      return ip;
    }
  }

  @override
  void setIP4(String ip) async {
    await sharedPreferences.setString(_ipKey, ip);
  }
}