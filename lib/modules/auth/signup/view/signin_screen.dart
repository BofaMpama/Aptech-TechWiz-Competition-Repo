import 'package:flutter/material.dart';
import 'package:pawfect/core/constants/app_color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/image_helper.dart';
import '../../../../shared/component/app_button.dart';
import '../../../../shared/component/page_input.dart';
import '../../../../shared/component/password_field.dart';
import '../../../../core/utils/email_validator.dart';
import '../components/user_model.dart';
import '../viewmodel/sigin_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String route = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => SignupViewModel(),
          child: Consumer<SignupViewModel>(
            builder: (context, viewModel, child) {
              // Set context in the viewModel
              WidgetsBinding.instance.addPostFrameCallback((_) {
                viewModel.setContext(context);
              });
              return SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 40.h),

                      // Logo
                      Center(
                        child: ImageHelper.buildNetworkImage(
                          'assets/pngs/splash.png',
                          width: 120.w,
                          height: 80.h,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // Full Name
                      PageInput(
                        hint: 'Becca Ade',
                        label: 'Full Name',
                        controller: viewModel.fullNameController,
                        onChanged: (_) => viewModel.clearError(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full name is required';
                          }
                          if (value.trim().length < 2) {
                            return 'Please enter a valid full name';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Email with Validation
                      PageInput(
                        hint: 'rhebhek@gmail.com',
                        label: 'Email Address',
                        controller: viewModel.emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => viewModel.clearError(),
                        textInputAction: TextInputAction.next,
                        validator: EmailValidator.validate,
                      ),

                      SizedBox(height: 20.h),

                      // Role Selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              'Select Role',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AppColors.lightGreen,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: const Color(0xFF153121),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonFormField<UserRole>(
                              value: viewModel.selectedRole,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                hintText: 'Select your role',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFC4C4C4),
                                  fontSize: 16.sp,
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a role';
                                }
                                return null;
                              },
                              items: UserRole.values.map((role) {
                                return DropdownMenuItem<UserRole>(
                                  value: role,
                                  child: Text(
                                    role.displayName,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (UserRole? newRole) {
                                if (newRole != null) {
                                  viewModel.setSelectedRole(newRole);
                                  viewModel.clearError();
                                }
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Password Field
                      PasswordField(
                        label: 'Password',
                        hintText: '••••••••',
                        controller: viewModel.passwordController,
                        onChanged: (_) => viewModel.clearError(),
                        customValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
                            return 'Password must contain at least one letter and one number';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Confirm Password Field
                      PasswordField(
                        label: 'Confirm Password',
                        hintText: '••••••••',
                        controller: viewModel.confirmPasswordController,
                        passwordController: viewModel.passwordController,
                        isConfirmField: true,
                        onChanged: (_) => viewModel.clearError(),
                      ),

                      SizedBox(height: 24.h),

                      // Terms Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: viewModel.acceptedTerms,
                            onChanged: (bool? value) {
                              viewModel.setAcceptedTerms(value ?? false);
                            },
                            activeColor: AppColors.primaryBlue,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => viewModel.setAcceptedTerms(!viewModel.acceptedTerms),
                              child: Text(
                                'By Creating an Account, I accept Hiring Hub terms of Use and Privacy Policy',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // Error Message
                      if (viewModel.errorMessage != null) ...[
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            viewModel.errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],

                      // Signup Button
                      AppButton(
                        title: 'Signup',
                        loading: viewModel.isLoading,
                        enabled: viewModel.acceptedTerms,
                        onPressed: () async {
                          // Clear any existing error
                          viewModel.clearError();

                          // Validate form first
                          if (!(_formKey.currentState?.validate() ?? false)) {
                            return;
                          }

                          // Check if terms are accepted
                          if (!viewModel.acceptedTerms) {
                            viewModel.setErrorMessage('Please accept the terms and conditions');
                            return;
                          }

                          // Check if role is selected
                          if (viewModel.selectedRole == null) {
                            viewModel.setErrorMessage('Please select a role');
                            return;
                          }

                          // Proceed with signup
                          await viewModel.signUp();
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Sign in link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an Account? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Text(
                              'Sign in here',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}