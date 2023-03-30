part of 'poll_bloc.dart';

abstract class PollState extends Equatable {
  const PollState();
}

class PollInitial extends PollState {
  @override
  List<Object> get props => [];
}

class PollStateSuccessful extends PollState {
  const PollStateSuccessful({required this.questions});
  final List<String> questions;
  @override
  List<Object?> get props => [questions];
}