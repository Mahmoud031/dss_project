import 'dart:developer';

import 'package:dss_project/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  Future deleteUser()async{
    await FirebaseAuth.instance.currentUser!.delete();
  }
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}and code: ${e.code}');
      if (e.code == 'weak-password') {
        throw CustomException(message: ' The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'The account already exists for that email.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'Please check your internet connection');
      } else {
        throw CustomException(
            message: 'An error occurred . please try again later');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred . please try again later');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}and code: ${e.code}');
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'the email or password is incorrect.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(
            message: 'the email or password is incorrect.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'Please check your internet connection');
      } else {
        throw CustomException(
            message: 'An error occurred . please try again later');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred . please try again later');
    }
  }
}
