import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/app_router/app_router.dart';
import '../../../domain/entities/quiz.dart';
import '../../../domain/entities/quiz_result.dart';
import '../../../domain/usecases/get_quiz_result.dart';
import '../../../domain/usecases/get_quiz.dart';
import '../../../domain/usecases/submit_quiz.dart';
import '../../screens/quiz_screen.dart';


part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuiz getQuiz;
  final GetQuizResult getQuizResult;
  final SubmitQuiz submitQuiz;
  QuizBloc({required this.getQuiz, required this.getQuizResult, required this.submitQuiz}) : super(QuizInitial()) {
    on<QuizEventSubmit>(_onSubmit);
    on<QuizEventGet>(_onGet);
    on<QuizEventGetResult>(_onGetResult);
  }

  FutureOr<void> _onSubmit(QuizEventSubmit event, Emitter<QuizState> emit) async {
    var result = await submitQuiz.call(event.answer);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: Colors.red,
            )
        );
      },
      (isHit) {
        ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(isHit ? 'Accept' : 'Wrong Answer'),
              backgroundColor: isHit ? Colors.green : Colors.red,
              duration: const Duration(milliseconds: 200),
            )
        );
    }
    );
  }

  FutureOr<void> _onGet(QuizEventGet event, Emitter<QuizState> emit) async {
    var result = await getQuiz.call();
    result.fold(
      (failure) {
        ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: Colors.red,
            )
        );
      },
      (quiz) {
        emit(QuizStateHasData(listQuiz: quiz, quizResult: event.quizResult));
        AppRouter.push(const QuizScreen());
      });
  }

  FutureOr<void> _onGetResult(QuizEventGetResult event, Emitter<QuizState> emit) async {
    var response = await getQuizResult.call();
    response.fold(
      (failure) {
        ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: Colors.red,
            )
        );
      },
      (result) {
        if(result.total == result.done) {
          int hitCount = 0;
          for(var hit in result.hit) {
            hitCount += int.parse(hit.toString());
          }
          ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
              SnackBar(
                content: Text('Your quiz has been done with the result: $hitCount/${result.total}'),
                backgroundColor: Colors.green,
              )
          );
        } else {
          add(QuizEventGet(quizResult: result));
        }
      });
  }
}
