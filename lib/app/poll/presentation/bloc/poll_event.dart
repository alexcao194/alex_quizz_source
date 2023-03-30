part of 'poll_bloc.dart';

abstract class PollEvent extends Equatable {
  const PollEvent();
}

class PollEventGet extends PollEvent {
  @override
  List<Object?> get props => [];
}

class PollEventSubmit extends PollEvent {
  const PollEventSubmit({required this.answers});
  final List<String> answers;
  @override
  List<Object?> get props => [answers];
}