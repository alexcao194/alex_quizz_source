import 'package:flutter/material.dart';

class BlankBox extends StatelessWidget {
  const BlankBox({
    Key? key,
    required this.controller
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size.height * 0.05,
        width: 60,
        child: TextField(
          maxLines: 1,
          controller: controller,
          textInputAction: TextInputAction.next,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
