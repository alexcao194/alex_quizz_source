part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationEventSignup extends AuthenticationEvent {
  const AuthenticationEventSignup({required this.account, required this.group, required this.email});
  final Account account;
  final int group;
  final String email;
  @override
  List<Object?> get props => [account, group, email];
}

class AuthenticationEventLogin extends AuthenticationEvent {
  const AuthenticationEventLogin({required this.account});
  final Account account;

  @override
  List<Object?> get props => [account];
}

class AuthenticationEventReLogin extends AuthenticationEvent {
  const AuthenticationEventReLogin();

  @override
  List<Object?> get props => [];
}