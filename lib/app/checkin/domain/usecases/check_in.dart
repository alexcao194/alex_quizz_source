import 'dart:io';

import '../../../../core/error/failures.dart';
import '../repositories/repositories.dart';

class CheckIn {
  const CheckIn({required this.repositories});
  final Repositories repositories;

  Future<Failure?> call(String name, File file, String id) async {
    return await repositories.checkIn(name, file, id);
  }
}