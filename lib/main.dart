import 'package:alex_quizz/app/authentication/presentation/bloc/ip/ip_cubit.dart';
import 'package:alex_quizz/app/checkin/presentation/bloc/checkin/check_in_cubit.dart';
import 'package:alex_quizz/app/poll/presentation/bloc/poll_bloc.dart';
import 'package:alex_quizz/app/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'app/authentication/presentation/bloc/account/account_cubit.dart';
import 'app/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'app/home/presentation/bloc/user_info/user_info_bloc.dart';
import 'injection_container.dart' as di;
import 'core/services/app_router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di.sl<AccountCubit>()),
            BlocProvider(create: (_) => di.sl<AuthenticationBloc>()),
            BlocProvider(create: (_) => di.sl<UserInfoBloc>()),
            BlocProvider(create: (_) => di.sl<CheckInCubit>()),
            BlocProvider(create: (_) => di.sl<IpCubit>()),
            BlocProvider(create: (_) => di.sl<QuizBloc>()),
            BlocProvider(create: (_) => di.sl<PollBloc>())
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alex Messenger',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: AppRouter.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
