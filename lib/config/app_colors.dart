import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
}

class AppGradients {
  const AppGradients._();
  static const primary = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 201, 161, 255),
      Color.fromARGB(255, 141, 173, 255)
    ]
  );
}