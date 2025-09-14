// splash_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel();

  Future<void> init(BuildContext context) async {
    // Simulate loading for 2 seconds (e.g., fetch user data, check auth)
    await Future.delayed(const Duration(seconds: 2));

    // Check authentication state
    await _checkAuthenticationAndNavigate(context);
  }

  Future<void> _checkAuthenticationAndNavigate(BuildContext context) async {
    if (!context.mounted) return;

    try {
      // Check if user is currently logged in
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // User is logged in
        if (kDebugMode) {
          print('User is logged in: ${currentUser.email}');
          print('User ID: ${currentUser.uid}');
        }

        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // User is not logged in
        if (kDebugMode) {
          print('No user logged in, navigating to signin');
        }

        // Navigate to signin screen
        Navigator.pushReplacementNamed(context, '/signin');
      }
    } catch (e) {
      // Handle any errors during auth check
      if (kDebugMode) {
        print('Error checking authentication: $e');
      }

      // Default to signin screen if there's an error
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/signin');
      }
    }
  }

  // Optional: Method to force logout and clear any cached auth data
  Future<void> clearAuthAndNavigateToSignIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/signin');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during logout: $e');
      }
    }
  }

  // Optional: Method to refresh authentication state
  Future<void> refreshAuthState(BuildContext context) async {
    await FirebaseAuth.instance.authStateChanges().first;
    await _checkAuthenticationAndNavigate(context);
  }
}