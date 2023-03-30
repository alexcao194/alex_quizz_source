part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
}

class QuizInitial extends QuizState {
  @override
  List<Object> get props => [];
}

class QuizStateHasData extends QuizState {
  const QuizStateHasData({required this.listQuiz, required this.quizResult});
  final List<Quiz> listQuiz;
  final QuizResult quizResult;
  @override
  List<Object?> get props => [listQuiz, quizResult];
}