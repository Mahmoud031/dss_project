import 'package:dss_project/core/helper_functions/build_error_bar.dart';
import 'package:dss_project/features/auth/presentation/cubits/sign_in_cubit.dart/signin_cubit.dart';
import 'package:dss_project/features/auth/presentation/views/widgets/sign_in_view_body.dart';
import 'package:dss_project/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInViewBodyBlocConsumer extends StatelessWidget {
  const SignInViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninFailure) {
         buildErrorBar(context, state.message);
        } else if (state is SigninSuccess) {
         buildErrorBar(context, 'sign in success');
          Navigator.pushNamed(context, HomeView.routeName);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(inAsyncCall: state is SigninLoading ? true : false, opacity: 0.5,
        child: const SignInViewBody());
      },
    );
  }
}
