import 'package:dss_project/core/helper_functions/build_error_bar.dart';

import 'package:dss_project/core/utils/app_text_styles.dart';
import 'package:dss_project/core/widgets/custom_button.dart';
import 'package:dss_project/core/widgets/custom_dropdown_field.dart';
import 'package:dss_project/core/widgets/custom_text_field.dart';
import 'package:dss_project/core/widgets/form_field_hint.dart';
import 'package:dss_project/core/widgets/password_field.dart';
import 'package:dss_project/features/auth/presentation/cubits/sign_up_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_link.dart';
import 'terms_and_conditions.dart';
import 'package:dss_project/main.dart';
import 'package:dss_project/features/data_export/data/repositories/data_export_repository.dart';

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

  // Form field values
  String? loanPurpose;
  bool? isMarried;
  String? dependents;
  String? income;
  String? loanAmount;
  String? age;
  String? creditHistory;

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
                        _buildFormField(
                          'Loan Purpose',
                          CustomDropdownField(
                            hintText: 'Select loan purpose',
                            items: const [
                              'EDUCATION',
                              'HOMEIMPROVEMENT',
                              'VENTURE',
                              'PERSONAL',
                              'MEDICAL',
                              'DEBTCONSOLIDATION'
                            ],
                            onSaved: (value) => loanPurpose = value,
                          ),
                          hintText:
                              'Select the purpose for which you need the loan',
                        ),
                        _buildFormField(
                          'Marital Status',
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<bool>(
                                  title: const Text('Yes'),
                                  value: true,
                                  groupValue: isMarried,
                                  onChanged: (value) {
                                    setState(() => isMarried = value);
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<bool>(
                                  title: const Text('No'),
                                  value: false,
                                  groupValue: isMarried,
                                  onChanged: (value) {
                                    setState(() => isMarried = value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          hintText: 'Please indicate if you are married or not',
                        ),
                        _buildFormField(
                          'Number of Dependents',
                          CustomDropdownField(
                            hintText: 'Select number of dependents',
                            items: const ['0', '1', '2', '3', '3+'],
                            onSaved: (value) => dependents = value,
                          ),
                          hintText:
                              'Select the number of people who depend on your income',
                        ),
                        _buildFormField(
                          'Income Level',
                          CustomDropdownField(
                            hintText: 'Select income level',
                            items: const ['low', 'medium', 'high'],
                            onSaved: (value) => income = value,
                          ),
                          hintText:
                              'low: less than 30,000\nmedium: 30,000 – 70,000\nhigh: more than 70,000',
                        ),
                        _buildFormField(
                          'Loan Amount',
                          CustomDropdownField(
                            hintText: 'Select loan amount',
                            items: const ['low', 'medium', 'high'],
                            onSaved: (value) => loanAmount = value,
                          ),
                          hintText:
                              'low: less than 3,200\nmedium: 3,200 – 9,450\nhigh: more than 9,450',
                        ),
                        _buildFormField(
                          'Age Category',
                          CustomDropdownField(
                            hintText: 'Select age category',
                            items: const ['young', 'middle-aged', 'old'],
                            onSaved: (value) => age = value,
                          ),
                          hintText:
                              'young: less than 22\nmiddle-aged: 22 – 50\nold: more than 50',
                        ),
                        _buildFormField(
                          'Credit History',
                          CustomDropdownField(
                            hintText: 'Select credit history',
                            items: const [
                              'Credit Builder',
                              'Developing Credit',
                              'Established Credit',
                              'Prime Credit'
                            ],
                            onSaved: (value) => creditHistory = value,
                          ),
                          hintText:
                              'Credit Builder (0–3)\nDeveloping Credit (4–6)\nEstablished Credit (7–9)\nPrime Credit (10–13)',
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
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                if (isTermsAccepted) {
                  // Store data in Google Sheets
                  final repo = DataExportRepository(sheetsService);
                  await repo.exportData({
                    'Name': userName,
                    'Email': email,
                    'Loan Purpose': loanPurpose,
                    'Marital Status': isMarried == true ? 'Yes' : 'No',
                    'Dependents': dependents,
                    'Income': income,
                    'Loan Amount': loanAmount,
                    'Age': age,
                    'Credit History': creditHistory,
                  });
                  context.read<SignupCubit>().createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                        name: userName,
                        loanPurpose: loanPurpose,
                        isMarried: isMarried,
                        dependents: dependents,
                        income: income,
                        loanAmount: loanAmount,
                        age: age,
                        creditHistory: creditHistory,
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
