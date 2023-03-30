import 'dart:io';

import '../../../../core/error/failures.dart';

abstract class Repositories {
  const Repositories();
  Future<Failure?> checkIn(String name, File file, String id);
}