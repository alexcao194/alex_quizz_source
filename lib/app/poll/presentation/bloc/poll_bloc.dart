import 'dart:async';

import 'package:alex_quizz/app/poll/presentation/screens/poll_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/app_router/app_router.dart';
import '../../domain/usecases/get.dart';
import '../../domain/usecases/submit.dart';

part 'poll_event.dart';
part 'poll_state.dart';

class PollBloc extends Bloc<PollEvent, PollState> {
  final Get get;
  final Submit submit;
  PollBloc({required this.submit, required this.get}) : super(PollInitial()) {
    on<PollEventGet>(_onGet);
    on<PollEventSubmit>(_onSubmit);
  }

  FutureOr<void> _onGet(PollEventGet event, Emitter<PollState> emit) async {
    var result = await get.call();
    result.fold(
      (failure) {
        ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: Colors.red,
            )
        );
      },
      (questions) {
        AppRouter.push(PollScreen());
        emit(PollStateSuccessful(questions: questions));
      });
  }

  FutureOr<void> _onSubmit(PollEventSubmit event, Emitter<PollState> emit) async {
    var result = await submit.call(event.answers);
    if(result == null) {
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('Submit form successful'),
            backgroundColor: Colors.green,
          )
      );
      AppRouter.pop();
    } else {
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          )
      );
    }
  }
}
