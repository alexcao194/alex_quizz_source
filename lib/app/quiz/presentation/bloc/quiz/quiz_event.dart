part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
}

class QuizEventGet extends QuizEvent {
  const QuizEventGet({required this.quizResult});

  final QuizResult quizResult;

  @override
  List<Object?> get props => [quizResult];
}

class QuizEventSubmit extends QuizEvent {
  const QuizEventSubmit({required this.answer});

  final String answer;

  @override
  List<Object?> get props => [answer];
}

class QuizEventGetResult extends QuizEvent {
  const QuizEventGetResult();
  @override
  List<Object?> get props => [];
}