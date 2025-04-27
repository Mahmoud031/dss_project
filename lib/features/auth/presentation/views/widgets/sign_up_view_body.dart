import 'package:dss_project/core/helper_functions/build_error_bar.dart';

import 'package:dss_project/core/utils/app_text_styles.dart';
import 'package:dss_project/core/widgets/custom_button.dart';
import 'package:dss_project/core/widgets/custom_text_field.dart';
import 'package:dss_project/core/widgets/password_field.dart';
import 'package:dss_project/features/auth/presentation/cubits/sign_up_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_link.dart';
import 'terms_and_conditions.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String email, userName, password;
  late bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Create an account',
            style: TextStyles.textstyle34,
          ),
          SignInLink(),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Color(0xff7F9593),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyles.textstyle25.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        userName = value!;
                      },
                      hintText: 'Enter your full name',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Email',
                      style: TextStyles.textstyle25.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        email = value!;
                      },
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Password',
                      style: TextStyles.textstyle25.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    PasswordField(
                      onSaved: (value) {
                        password = value!;
                      },
                      hintText: 'Enter your password',
                    ),
                    const SizedBox(height: 20),
                    TermsAndConditions(
                      onChanged: (value) {
                        isTermsAccepted = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Sign Up',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                if (isTermsAccepted) {
                  context.read<SignupCubit>().createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                        name: userName,
                      );
                } else {
                  buildErrorBar(
                    context,
                    'Please accept the terms and conditions',
                  );
                }
              } else {
                setState(() {
                  autoValidateMode = AutovalidateMode.always;
                });
              }
            },
            size: const Size(300, 50),
          ),
        ],
      ),
    );
  }
}
