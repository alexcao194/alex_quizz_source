part of 'test_bloc.dart';

abstract class TestState extends Equatable {
  const TestState();
}

class TestInitial extends TestState {
  @override
  List<Object> get props => [];
}

class TestStateGenerateDone extends TestState {
  const TestStateGenerateDone({required this.currentTest, required this.test, required this.controllers, required this.countTest});

  final List<List<Widget>> test;
  final List<List<TextEditingController>> controllers;
  final int countTest;
  final int currentTest;

  @override
  List<Object> get props => [test, controllers, countTest, currentTest];
}