part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();
}

class UserInfoInitial extends UserInfoState {
  const UserInfoInitial();
  @override
  List<Object> get props => [];
}

class UserInfoStateLoading extends UserInfoState {
  @override
  List<Object?> get props => [];
}

class UserInfoStateFail extends UserInfoState {
  const UserInfoStateFail({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class UserInfoStateSuccessful extends UserInfoState {
  const UserInfoStateSuccessful({required this.userInfo});
  final UserInfoEntity userInfo;
  @override
  List<Object?> get props => [userInfo];
}