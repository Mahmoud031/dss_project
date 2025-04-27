
import 'package:dss_project/core/services/get_it_service.dart';
import 'package:dss_project/core/utils/app_colors.dart';
import 'package:dss_project/features/auth/domain/repos/auth_repo.dart';
import 'package:dss_project/features/auth/presentation/cubits/sign_up_cubit/signup_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sign_up_view_body_bloc_consumer.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routeName = 'signUp';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SignUpViewBodyBlocConsumer(),
      ),
    );
  }
}


