import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
abstract class RemoteData {
  const RemoteData();
  Future<void> checkIn(String name, File file, String id, String ip);
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;

  @override
  Future<void> checkIn(String name, File file, String id, String ip) async {
    var postUri = Uri.http(ip, 'check-in', {});
    var req = http.MultipartRequest("POST", postUri);
    await http.MultipartFile.fromPath('checkin', file.path, filename: '$name/$id.jpg').then((file) {
      req.files.add(file);
    });
    http.StreamedResponse response = await req.send();
    print(response.statusCode.toString());
  }
}