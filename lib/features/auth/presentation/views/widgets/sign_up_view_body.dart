import 'package:dss_project/core/helper_functions/build_error_bar.dart';
import 'package:dss_project/core/utils/app_text_styles.dart';
import 'package:dss_project/core/widgets/custom_button.dart';
import 'package:dss_project/core/widgets/custom_text_field.dart';
import 'package:dss_project/core/widgets/form_field_hint.dart';
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

class _SignUpViewBodyState extends State<SignUpViewBody>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String email, userName, password;
  late bool isTermsAccepted = false;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              color: const Color(0xff7F9593),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFormField(
                          'Name',
                          CustomTextFormField(
                            onSaved: (value) => userName = value!,
                            hintText: 'Enter your full name',
                            prefixIcon: Icons.person,
                          ),
                        ),
                        _buildFormField(
                          'Email',
                          CustomTextFormField(
                            onSaved: (value) => email = value!,
                            hintText: 'Enter your email',
                            prefixIcon: Icons.email,
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                        _buildFormField(
                          'Password',
                          PasswordField(
                            onSaved: (value) => password = value!,
                            hintText: 'Enter your password',
                          ),
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

  Widget _buildFormField(String label, Widget field, {String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyles.textstyle25.copyWith(
                color: Colors.black,
              ),
            ),
            if (hintText != null) ...[
              const SizedBox(width: 8),
              FormFieldHint(hintText: hintText),
            ],
          ],
        ),
        const SizedBox(height: 8),
        field,
        const SizedBox(height: 20),
      ],
    );
  }
}
