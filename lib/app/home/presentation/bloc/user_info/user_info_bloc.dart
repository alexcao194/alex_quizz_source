import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_info.dart';
import '../../../domain/usecases/get_info.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc({required this.getInfo}) : super(const UserInfoInitial()) {
    on<UserInfoEventGet>(_onGet);
  }

  final GetInfo getInfo;

  FutureOr<void> _onGet(UserInfoEventGet event, Emitter<UserInfoState> emit) async {
    emit(UserInfoStateLoading());
    var result = await getInfo.call();
    result.fold(
      (failure) => emit(UserInfoStateFail(message: failure.message)),
      (user) => emit(UserInfoStateSuccessful(userInfo: user))
    );
  }
}
