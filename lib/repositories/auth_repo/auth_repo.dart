import 'package:dartz/dartz.dart';
import 'package:task_manager_app/models/user_data_model.dart';

import '../../core/networks/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserDataModel>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, UserDataModel>> getCurrentUserData();
}
