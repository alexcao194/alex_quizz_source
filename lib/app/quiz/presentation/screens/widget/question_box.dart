import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  const QuestionBox({Key? key, required this.content,}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: content
    );
  }
}