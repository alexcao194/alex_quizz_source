import 'package:alex_quizz/app/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:alex_quizz/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/multi_choice_quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>{

  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var q = BlocProvider.of<QuizBloc>(context).state;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        pageController.jumpToPage(q is QuizStateHasData ? q.quizResult.done : 0);
      }
    });
    super.didChangeDependencies();
  }


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, quizState) {
                if(quizState is QuizStateHasData) {
                  return Stack(
                    children: [
                      PageView.builder(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: quizState.quizResult.total,
                        itemBuilder: (BuildContext context, int index) {
                          return MultiChoiceQuiz(
                            pageController: pageController,
                            totalQuestion: quizState.quizResult.total,
                            page: index,
                            quiz: quizState.listQuiz[index].question,
                            answer1: quizState.listQuiz[index].answer[0],
                            answer2: quizState.listQuiz[index].answer[1],
                            answer3: quizState.listQuiz[index].answer[2],
                            answer4: quizState.listQuiz[index].answer[3],
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
          )),
    );
  }
}
