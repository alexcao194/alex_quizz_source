import 'dart:convert';

import 'package:alex_quizz/app/quiz/data/models/quiz.dart';
import 'package:alex_quizz/app/quiz/data/models/quiz_result.dart';
import 'package:alex_quizz/app/quiz/domain/entities/quiz.dart';
import 'package:alex_quizz/app/quiz/domain/entities/quiz_result.dart';
import 'package:dio/dio.dart';

abstract class RemoteData {
  const RemoteData();
  Future<List<Quiz>> getQuiz(String token, String ip);
  Future<QuizResult> getResult(String token, String ip);
  Future<bool> submitQuiz(String token, String ip, String answer);
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;
  @override
  Future<List<Quiz>> getQuiz(String token, String ip) async {
    var response = await dio.get('http://$ip/quiz',
      options: Options(
        headers: {
          'x-access-token' : token
        }
      ),
    );
    var data = response.data;
    var listQuiz = <Quiz>[];
    for (var quiz in data) {
      listQuiz.add(QuizModal.fromJson(quiz));
    }
    return listQuiz;
  }

  @override
  Future<QuizResult> getResult(String token, String ip) async {
    var response = await dio.get('http://$ip/quiz-result',
      options: Options(
          headers: {
            'x-access-token' : token
          }
      ),
    );
    if(response.data['total'] == 0) {
      throw DioError(requestOptions: RequestOptions(path: 'get'), error: 'quiz-is-empty');
    }
    return QuizResultModal.fromJson(response.data);
  }

  @override
  Future<bool> submitQuiz(String token, String ip, String answer) async {
    var response = await dio.post('http://$ip/submit-quiz',
      options: Options(
        headers: {
          'x-access-token' : token
        }
      ),
      queryParameters: {
        "answer" : answer
      }
    );
    return response.data == 1;
  }
}