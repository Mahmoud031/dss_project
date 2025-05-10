import 'package:bloc/bloc.dart';
import 'package:dss_project/features/auth/domain/entities/user_entity.dart';
import 'package:dss_project/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;
  
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? loanPurpose,
    bool? isMarried,
    String? dependents,
    String? income,
    String? loanAmount,
    String? age,
    String? creditHistory,
  }) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      loanPurpose: loanPurpose,
      isMarried: isMarried,
      dependents: dependents,
      income: income,
      loanAmount: loanAmount,
      age: age,
      creditHistory: creditHistory,
    );
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
