import 'package:alex_quizz/app/quiz/domain/entities/quiz.dart';

class QuizModal extends Quiz {
  QuizModal({required super.question, required super.answer});

  factory QuizModal.fromJson(Map<String, dynamic> json) {
    var listAnswerData = json['answer'];
    var listAnswer = <String>[];
    for(var answer in listAnswerData) {
      listAnswer.add(answer.toString());
    }
    return QuizModal(
        question: json['question'],
        answer: listAnswer
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer
    };
  }
}