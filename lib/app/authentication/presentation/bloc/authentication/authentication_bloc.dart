import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/app_router/app_router.dart';
import '../../../../home/presentation/screens/home_screen.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/usecases/get_account.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/signup.dart';
import '../../screens/login_screen.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Signup signup;
  final Login login;
  final GetAccount getAccount;
  AuthenticationBloc({required this.signup, required this.login, required this.getAccount}) : super(AuthenticationInitial()) {
    on<AuthenticationEventSignup>(_onSignup);
    on<AuthenticationEventLogin>(_onLogin);
    on<AuthenticationEventReLogin>(_onReLogin);
  }

  FutureOr<void> _onSignup(AuthenticationEventSignup event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationStateLoading());
    Account account = event.account;
    var failure = await signup.call(account, event.group, event.email);
    if(failure == null) {
      emit(AuthenticationInitial());
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('Signup successful!'),
            backgroundColor: Colors.green,
          )
      );
      AppRouter.pushReplacement(const LoginScreen());
    } else {
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(failure.message),
          backgroundColor: Colors.red,
        )
      );
      emit(AuthenticationStateSignUpFail(message: failure.message));
    }
  }

  FutureOr<void> _onLogin(AuthenticationEventLogin event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationStateLoading());
    var failure = await login.call(event.account);
    if(failure != null) {
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Colors.red,
          )
      );
      emit(AuthenticationStateLoginFail(message: failure.message));
      AppRouter.pushReplacement(const LoginScreen());
    } else {
      emit(const AuthenticationStateLoginSuccessful());
      AppRouter.pushReplacement(const HomeScreen());
    }
  }


  FutureOr<void> _onReLogin(AuthenticationEventReLogin event, Emitter<AuthenticationState> emit) {
    AppRouter.pushReplacement(const LoginScreen());
  }
}
