import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dss_project/core/errors/exceptions.dart';
import 'package:dss_project/core/errors/failures.dart';
import 'package:dss_project/core/services/database_service.dart';
import 'package:dss_project/core/services/firebase_auth_service.dart';
import 'package:dss_project/core/utils/backend_endpoint.dart';
import 'package:dss_project/features/auth/data/models/user_model.dart';
import 'package:dss_project/features/auth/domain/entities/user_entity.dart';
import 'package:dss_project/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(
      {required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    User? user;
    try {
       user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
      var userEntity = UserEntity(name: name, email: email, uId: user.uid);
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      if(user != null) {
        await firebaseAuthService.deleteUser();
      }
      return left(ServerFailure(e.message));
    } catch (e) {
      if(user != null) {
        await firebaseAuthService.deleteUser();
      }
      log('Exception in AuthrepoImpl.createUserWithEmailAndPassword: ${e.toString()}');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
          var userEntity =  await getUserData(uId: user.uid);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthrepoImpl.signInWithEmailAndPassword: ${e.toString()}');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
        path: BackendEndpoint.addUserData, data: user.toMap(), documentId: user.uId);
  }
  
  @override
  Future<UserEntity> getUserData({required String uId}) async{
    var userData = await databaseService.getData(
        path: BackendEndpoint.getUserData, documentId: uId);
    return UserModel.fromJson(userData);
    }
}
