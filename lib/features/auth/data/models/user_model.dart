import 'package:dss_project/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name, 
    required super.email, 
    required super.uId,
    super.loanPurpose,
    super.isMarried,
    super.dependents,
    super.income,
    super.loanAmount,
    super.age,
    super.creditHistory,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      loanPurpose: json['loanPurpose'],
      isMarried: json['isMarried'],
      dependents: json['dependents'],
      income: json['income'],
      loanAmount: json['loanAmount'],
      age: json['age'],
      creditHistory: json['creditHistory'],
    );
  }
}