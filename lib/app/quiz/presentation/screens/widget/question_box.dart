import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  const QuestionBox({Key? key, required this.content,}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: content
    );
  }
}