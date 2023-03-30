part of 'check_in_cubit.dart';

abstract class CheckInState extends Equatable {
  const CheckInState();
}

class CheckInInitial extends CheckInState {
  @override
  List<Object> get props => [];
}
