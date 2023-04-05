import 'package:flutter/material.dart';

import 'widget/fill_blank_quiz.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Scaffold(
        body: FillBlankQuiz(),
      ),
    );
  }
}
