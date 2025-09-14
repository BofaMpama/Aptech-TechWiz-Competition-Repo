import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modules/auth/signup/viewmodel/sigin_viewmodel.dart';
import '../../modules/splashscreen/viewmodel/splash_view_model.dart';



class Providers {
  static Widget provide({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        // ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
      //   ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      //   ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
      //   ChangeNotifierProvider(create: (_) => ResetPasswordViewModel()),
      ],
      child: child,
    );
  }
}
