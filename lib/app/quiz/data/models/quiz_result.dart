import 'package:alex_quizz/app/quiz/domain/entities/quiz_result.dart';

class QuizResultModal extends QuizResult {
  QuizResultModal({required super.total, required super.done, required super.hit});

  factory QuizResultModal.fromJson(Map<String, dynamic> json) {
    List<int> hitData = [];
    for(var isHit in json['hit']) {
      hitData.add(isHit);
    }
    return QuizResultModal(
      done: json['done'],
      hit: hitData,
      total: json['total']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'done' : done,
      'hit' : hit,
      'total' : total
    };
  }
}