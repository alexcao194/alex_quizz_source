import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/authentication/presentation/bloc/account/account_cubit.dart';
import 'app/authentication/presentation/bloc/authentication/authentication_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const AuthenticationEventReLogin());
    context.read<AccountCubit>().get();
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.9],
              colors: [
                Color(0xFFFC5C7D),
                Color(0xFF6A82FB),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 90.0),
          child: const Icon(Icons.flutter_dash)
      ),
    );
  }
}
