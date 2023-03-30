import 'package:alex_quizz/app/checkin/presentation/screens/check_in_screen.dart';
import 'package:alex_quizz/app/poll/presentation/bloc/poll_bloc.dart';
import 'package:alex_quizz/app/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:alex_quizz/config/app_colors.dart';
import 'package:alex_quizz/core/services/app_router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'widgets/home_app_bar.dart';
import 'widgets/home_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.primary),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: HomeAppBar(context: context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeItem(
                  header: const Icon(Icons.check),
                  label: 'Check in',
                  onTap: () {
                    AppRouter.push(const CheckInScreen());
                  },
                ),
                HomeItem(
                    header: const Icon(Icons.poll_outlined),
                    label: 'Poll',
                    onTap: () {
                      BlocProvider.of<PollBloc>(context).add(PollEventGet());
                    },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeItem(
                    header: const Icon(Icons.quiz),
                    label: 'Quiz',
                    onTap: () {
                      BlocProvider.of<QuizBloc>(context).add(const QuizEventGetResult());
                    }),
                const HomeItem(header: Icon(Icons.question_mark), label: 'Contest'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
