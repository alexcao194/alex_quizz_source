import 'package:dio/dio.dart';

abstract class RemoteData {
  const RemoteData();
  Future<List<String>> get(String ip, String token);
  Future<void> submit(List<String> answers, String ip, String token);
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;
  @override
  Future<List<String>> get(String ip, String token) async {
    var response = await dio.get('http://$ip/poll',
      options: Options(
        headers: {
          'x-access-token' : token,
        }
      ),
      queryParameters: {

      }
    );
    List<String> questions = [];
    for(var data in response.data) {
      questions.add(data);
    }
    if(questions.isEmpty) {
      throw DioError(requestOptions: RequestOptions(path: 'get'), error: 'poll-is-empty');
    }
    return questions;
  }

  @override
  Future<void> submit(List<String> answers, String ip, String token) async {
    await dio.post('http://$ip/submit-poll',
      options: Options(
        headers: {
          'x-access-token' : token,
        }
      ),
      queryParameters: {
        "answers" : answers
      }
    );
  }
}