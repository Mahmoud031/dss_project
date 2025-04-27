import 'package:dartz/dartz.dart';
import 'package:dss_project/core/errors/failures.dart';
import 'package:dss_project/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uId});
}
