import 'package:alex_core/alex_core.dart';
import 'package:alex_quizz/app/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:alex_quizz/core/services/app_router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'question_box.dart';

class MultiChoiceQuiz extends StatefulWidget {
  const MultiChoiceQuiz({
    Key? key, required this.quiz, required this.answer1, required this.answer2, required this.answer3, required this.answer4, required this.page, required this.pageController, required this.totalQuestion,
  }) : super(key: key);

  final String quiz;
  final int page;
  final int totalQuestion;
  final PageController pageController;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;

  @override
  State<MultiChoiceQuiz> createState() => _MultiChoiceQuizState();
}

class _MultiChoiceQuizState extends State<MultiChoiceQuiz> {

  String pickedAnswer = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.08),
            const Text('Chọn đáp án đúng',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700)),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: QuestionBox(
                content: Center(
                  child: SingleChildScrollView(child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: buildTex(widget.quiz.split(r"$")),
                  )),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: InkWellButton(
                    height: size.height * 0.1,
                    backgroundColor: Colors.red,
                    primaryColor: Colors.red,
                    radius: 10.0,
                    isActive: pickedAnswer == 'A',
                    onTap: () {
                      setState(() {
                        pickedAnswer = 'A';
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildTex(widget.answer1.split(r"$")),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: InkWellButton(
                    height: size.height * 0.1,
                    backgroundColor: Colors.red,
                    primaryColor: Colors.red,
                    isActive: pickedAnswer == 'B',
                    onTap: () {
                      setState(() {
                        pickedAnswer = 'B';
                      });
                    },
                    radius: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildTex(widget.answer2.split(r"$")),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: InkWellButton(
                    height: size.height * 0.1,
                    backgroundColor: Colors.red,
                    primaryColor: Colors.red,
                    radius: 10.0,
                    isActive: pickedAnswer == 'C',
                    onTap: () {
                      setState(() {
                        pickedAnswer = 'C';
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildTex(widget.answer3.split(r"$")),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: InkWellButton(
                    height: size.height * 0.1,
                    backgroundColor: Colors.red,
                    primaryColor: Colors.red,
                    radius: 10.0,
                    isActive: pickedAnswer == 'D',
                    onTap: () {
                      setState(() {
                        pickedAnswer = 'D';
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildTex(widget.answer4.split(r"$")),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: InkWellButton(
          primaryColor: pickedAnswer.isNotEmpty ? Colors.red : Colors.black12,
          height: 60,
          radius: 10.0,
          isActive: true,
          onTap: pickedAnswer.isNotEmpty ? () {
            BlocProvider.of<QuizBloc>(context).add(QuizEventSubmit(answer: pickedAnswer));
            if (widget.totalQuestion == widget.pageController.page!.floor() + 1) {
              AppRouter.pop();
            } else {
              widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
            }
          } : null,
          child: const Text('Submit', style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white)),
        ),
      ),
    );
  }

  Widget buildTex(List<String> tex) {
    var listTex = <Widget>[];
    int sizeOfListTex = tex.length;
    for(int i = 0; i < sizeOfListTex; i++) {
      if(i % 2 == 0) {
        listTex.add(Text(tex[i]));
      } else {
        listTex.add(Math.tex(tex[i]));
      }
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: listTex
    );
  }
}