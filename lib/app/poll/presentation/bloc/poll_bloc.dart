import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      (failure) => {

      },
      (questions) => {
        print(questions)
      });
  }

  FutureOr<void> _onSubmit(PollEventSubmit event, Emitter<PollState> emit) {
  }
}
