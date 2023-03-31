import 'package:alex_quizz/app/poll/presentation/screens/poll_screen.dart';
import 'package:flutter/material.dart';

import '../../../app/authentication/presentation/screens/login_screen.dart';
import '../../../app/checkin/presentation/screens/check_in_screen.dart';
import '../../../app/home/presentation/screens/home_screen.dart';
import '../../../app/home/presentation/screens/profile_screen.dart';
import '../../../app/quiz/presentation/screens/quiz_screen.dart';
import '../../../splash_screen.dart';
class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.checkIn:
        return MaterialPageRoute(builder: (_) => const CheckInScreen());
      case AppRoutes.quiz:
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case AppRoutes.poll:
        return MaterialPageRoute(builder: (_) => PollScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
                child: Text('Fallback')
            ),
        ));
    }
  }

  static push(Widget widget) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => widget));
  }

  static pushReplacement(Widget widget) {
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => widget));
  }

  static pop() {
    if(navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState?.pop();
    }
  }
}

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String checkIn = '/check_in';
  static const String quiz = '/quiz';
  static const String poll = '/poll';
}