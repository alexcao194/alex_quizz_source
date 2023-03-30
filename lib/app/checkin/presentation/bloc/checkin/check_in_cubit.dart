import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../core/services/app_router/app_router.dart';
import '../../../domain/usecases/check_in.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckIn checkIn;
  CheckInCubit({required this.checkIn}) : super(CheckInInitial());

  void onCheck(String name, File file, String id) async {
    var failure = await checkIn.call(name, file, id).then((value) {
      AppRouter.pop();
    });
    if(failure == null) {
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('Check in successful!'),
            backgroundColor: Colors.green,
          )
      );
    } else {
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Colors.red,
          )
      );
    }
  }
}
