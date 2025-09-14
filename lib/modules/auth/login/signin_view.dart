import 'package:flutter/material.dart';
import 'package:pawfect/modules/auth/login/signin_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect/core/constants/app_color.dart';

import '../../../../core/utils/image_helper.dart';
import '../../../../shared/component/app_button.dart';
import '../../../../shared/component/page_input.dart';
import '../../../../shared/component/password_field.dart';
import '../../../../core/utils/email_validator.dart';
import '../signup/view/signin_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String route = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => SignInViewModel(),
          child: Consumer<SignInViewModel>(
            builder: (context, viewModel, child) {
              // Set context in the viewModel
              WidgetsBinding.instance.addPostFrameCallback((_) {
                viewModel.setContext(context);
              });

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 400.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.all(32.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Logo Section
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryBlue,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pets,
                                  size: 40.sp,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pawfect',
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryBlue,
                                      ),
                                    ),
                                    Text(
                                      'Care',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Email Address
                          PageInput(
                            hint: 'Rhebhek@gmail.com',
                            label: 'Email Address',
                            controller: viewModel.emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (_) => viewModel.clearError(),
                            textInputAction: TextInputAction.next,
                            validator: EmailValidator.validate,
                          ),

                          SizedBox(height: 20.h),

                          // Password
                          PageInput(
                            hint: '••••••••',
                            label: 'Password',
                            controller: viewModel.passwordController,
                            obscureText: true,
                            onChanged: (_) => viewModel.clearError(),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 8.h),

                          // Password Error
                          if (viewModel.showPasswordError) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Please enter correct password',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                          ],

                          // General Error Message
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

                          SizedBox(height: 16.h),

                          // Sign In Button
                          AppButton(
                            title: 'Signin',
                            loading: viewModel.isLoading,
                            onPressed: () async {
                              // Clear any existing error
                              viewModel.clearError();

                              // Validate form first
                              if (!(_formKey.currentState?.validate() ?? false)) {
                                return;
                              }

                              // Proceed with signin
                              await viewModel.signIn();
                            },
                          ),

                          SizedBox(height: 24.h),

                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an Account? ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, SignupScreen.route);
                                },
                                child: Text(
                                  'Sign up here',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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