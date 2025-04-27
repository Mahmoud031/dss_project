import 'package:dss_project/core/utils/app_colors.dart';
import 'package:dss_project/core/utils/app_images.dart';
import 'package:dss_project/core/utils/app_text_styles.dart';

import 'package:dss_project/core/widgets/custom_button.dart';
import 'package:dss_project/core/widgets/custom_text_field.dart';
import 'package:dss_project/core/widgets/dont_have_account.dart';
import 'package:dss_project/core/widgets/password_field.dart';
import 'package:dss_project/features/auth/presentation/cubits/sign_in_cubit.dart/signin_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  late String email, password;
   AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: Column(
              children: [
                Image.asset(
                  AppImages.signInImage,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.53,
                  decoration: ShapeDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Form(
                          key: formKey,
                          autovalidateMode: autoValidateMode,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 70,
                              ),
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
                                hintText: 'Enter your Email',
                                prefixIcon: Icons.person_outline_rounded,
                                textInputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
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
                                hintText: 'Enter your Password',
                              ),
                              
                              const SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                text: "Sign In",
                                size: Size(
                                    MediaQuery.of(context).size.width * 0.6,
                                    MediaQuery.of(context).size.height * 0.07),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    context
                                        .read<SigninCubit>()
                                        .signInWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                  }else {
                                   autoValidateMode = AutovalidateMode.always;
                                   setState(() {});
                                  }
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              const DontHaveAccount(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
