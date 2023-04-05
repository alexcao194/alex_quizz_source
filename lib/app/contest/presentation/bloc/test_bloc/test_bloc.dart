import 'dart:async';

import 'package:alex_quizz/app/contest/presentation/screens/contest_screen.dart';
import 'package:alex_quizz/core/services/app_router/app_router.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../../domain/usecases/get.dart';
import '../../../domain/usecases/submit.dart';
import '../../../domain/usecases/get_info.dart';
import '../../screens/widget/blank_box.dart';

part 'test_event.dart';

part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final Get get;
  final GetInfo getInfo;
  final Submit submit;
  TestBloc({required this.get, required this.submit, required this.getInfo}) : super(TestInitial()) {
    on<TestEventGet>(_onGet);
    on<TestEventSubmit>(_onSubmit);
    on<TestEventGetInfo>(_onGetInfo);
  }

  FutureOr<void> _onGet(TestEventGet event, Emitter<TestState> emit) async {
    var result = await get.call();
    result.fold((failure) => null, (result) {
      List<List<Widget>> tests = [];
      List<List<TextEditingController>> controllerss = [];
      for (int o = 0; o < result.length; o++) {
        List<Widget> test = [];
        List<TextEditingController> controllers = [];
        int testLength = result[o].length;
        for (int i = 0; i < testLength; i++) {
          int sentenceLength = result[o]['sentence_${i + 1}'].length;
          if (result[o]['sentence_${i + 1}'][0] == '' && sentenceLength == 1) {
            test.add(const Text('\n', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
            continue;
          } else if (result[o]['sentence_${i + 1}'][0].toString().startsWith('\$')) {
            test.add(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Math.tex(result[o]['sentence_${i + 1}'][0].toString().replaceAll('\$', ''), textStyle: const TextStyle(fontWeight: FontWeight.bold)),
            ));
          } else {
            for (int j = 0; j < sentenceLength; j++) {
              if (j == 0) {
                test.add(Text(result[o]['sentence_${i + 1}'][j].toString().replaceAll(r'''<endline/>''', ''), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
              } else {
                controllers.add(TextEditingController());
                test.add(BlankBox(controller: controllers.last));
                test.add(Text(result[o]['sentence_${i + 1}'][j].toString().replaceAll(r'''<endline/>''', ''), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
              }
              if (result[o]['sentence_${i + 1}'][j].toString().endsWith(r'''<endline/>''')) {
                test.add(const SizedBox(width: double.maxFinite));
              }
            }
          }
        }
        controllerss.add(controllers);
        tests.add(test);
      }
      emit(TestStateGenerateDone(test: tests, controllers: controllerss, countTest: result.length, currentTest: event.currentTest));
      AppRouter.push(const TestScreen());
    });
  }

  FutureOr<void> _onSubmit(TestEventSubmit event, Emitter<TestState> emit) async {
    List<String> result = [];
    for (int i = 0; i < event.controllers.length; i++) {
      if (event.controllers[i].value.text != '') {
        result.add(event.controllers[i].value.text);
      } else {
        showDialog(
            context: AppRouter.navigatorKey.currentState!.context,
            builder: (context) {
              return AlertDialog(
                content: const Text('Hãy điền tất cả các trường trước khi nộp'),
                actions: [
                  TextButton(
                      onPressed: () {
                        AppRouter.pop();
                      },
                      child: const Text('ok', style: TextStyle(color: Colors.red)))
                ],
              );
            });
        break;
      }
    }
    if (result.length == event.controllers.length) {
      showDialog(
          context: AppRouter.navigatorKey.currentState!.context,
          builder: (context) {
            return AlertDialog(
              content: const Text('Sau khi bấm nộp bài sẽ không thể quay lại, bạn có chắc muốn nộp bài?'),
              actions: [
                TextButton(
                    onPressed: () {
                      AppRouter.pop();
                    },
                    child: const Text('Hủy', style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () async {
                      AppRouter.pop();
                      var failure = await submit.call(event.test, result);
                      if(failure == null) {
                        if (event.totalTest != event.test + 1) {
                          event.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
                        } else {
                          AppRouter.pop();
                        }
                      } else {
                        ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
                            SnackBar(
                              content: Text(failure.message),
                              backgroundColor: Colors.red,
                            )
                        );
                      }
                    },
                    child: const Text('Nộp', style: TextStyle(color: Colors.red)))
              ],
            );
          });
    } else {
      // do sth
    }
  }

  FutureOr<void> _onGetInfo(TestEventGetInfo event, Emitter<TestState> emit) async {
    var result = await getInfo.call();
    result.fold(
      (failure) {
        ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: Colors.red,
            )
        );
      },
      (info) {
        if(info['total'] == info['current']) {
          ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
              const SnackBar(
                content: Text('Done'),
                backgroundColor: Colors.green,
              )
          );
        } else {
          add(TestEventGet(currentTest: info['current']!));
        }
      }
    );
  }
}
