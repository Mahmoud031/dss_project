import 'package:dss_project/core/services/get_it_service.dart';
import 'package:dss_project/features/auth/domain/repos/auth_repo.dart';
import 'package:dss_project/features/auth/presentation/cubits/sign_in_cubit.dart/signin_cubit.dart';

import 'package:dss_project/features/auth/presentation/views/widgets/sign_in_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const routeName = 'signIn';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SignInViewBodyBlocConsumer(),
      ),
    );
  }
}

