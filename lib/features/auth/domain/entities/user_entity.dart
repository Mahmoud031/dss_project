class UserEntity {
  final String name;
  final String email;
  final String uId;
  final String? loanPurpose;
  final bool? isMarried;
  final String? dependents;
  final String? income;
  final String? loanAmount;
  final String? age;
  final String? creditHistory;

  UserEntity({
    required this.name, 
    required this.email, 
    required this.uId,
    this.loanPurpose,
    this.isMarried,
    this.dependents,
    this.income,
    this.loanAmount,
    this.age,
    this.creditHistory,
  });

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'loanPurpose': loanPurpose,
      'isMarried': isMarried,
      'dependents': dependents,
      'income': income,
      'loanAmount': loanAmount,
      'age': age,
      'creditHistory': creditHistory,
    };
  }
}
