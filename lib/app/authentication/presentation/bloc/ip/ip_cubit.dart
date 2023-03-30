import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/getIp4.dart';
import '../../../domain/usecases/setIp4.dart';

part 'ip_state.dart';

class IpCubit extends Cubit<String> {
  GetIP4 getIP4;
  SetIP4 setIP4;
  IpCubit({required this.setIP4, required this.getIP4}) : super('');

  String get() {
    return getIP4.call();
  }

  void set(String ip) {
    setIP4.call(ip);
  }
}
