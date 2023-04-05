part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();
}

class TestEventGet extends TestEvent {
  const TestEventGet({required this.currentTest});

  final int currentTest;

  @override
  List<Object?> get props => [currentTest];
}

class TestEventSubmit extends TestEvent {
  const TestEventSubmit({required this.pageController, required this.test, required this.totalTest, required this.controllers});

  final PageController pageController;
  final List<TextEditingController> controllers;
  final int test;
  final int totalTest;

  @override
  List<Object?> get props => [pageController, test, totalTest, controllers];
}

class TestEventGetInfo extends TestEvent {
  const TestEventGetInfo();

  @override
  List<Object?> get props => [];
}