import 'package:alex_core/alex_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../quiz/presentation/screens/widget/question_box.dart';
import '../../bloc/test_bloc/test_bloc.dart';

class FillBlankQuiz extends StatelessWidget {
  const FillBlankQuiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, testState) {
        if(testState is TestStateGenerateDone) {
          final pageController = PageController(
              initialPage: testState.currentTest
          );
          return Stack(
            children: [
              PageView.builder(
                controller: pageController,
                physics: const ScrollPhysics(
                    parent: NeverScrollableScrollPhysics()
                ),
                itemCount: testState.countTest,
                itemBuilder: (context, index) {
                  return buildBody(size, testState, index, context, pageController);
                },
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildBody(Size size, TestStateGenerateDone testState, int test, BuildContext context, PageController pageController) {
    return Stack(
      children: [
        SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.08),
                  const Text('Hoàn thành câu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: QuestionBox(
                      content: Center(
                        child: Text('Điền từ còn thiếu'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: testState.test[test]
                          ),
                          SizedBox(height: size.height * 0.04, width: double.maxFinite)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        Column(
          children: [
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: InkWellButton(
                primaryColor: Colors.red,
                height: 60,
                radius: 10.0,
                isActive: true,
                onTap: () {
                  BlocProvider.of<TestBloc>(context).add(TestEventSubmit(
                      pageController: pageController,
                      test: test,
                      totalTest: testState.countTest,
                      controllers: testState.controllers[test]
                  ));
                },
                child: const Text('Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            )
          ],
        )
      ],
    );
  }
}




