import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Navigation context
  BuildContext? _context;

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  bool _showPasswordError = false;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get showPasswordError => _showPasswordError;

  // Form validation getter
  bool get isFormValid {
    return emailController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  // Methods
  void setContext(BuildContext context) {
    _context = context;
  }

  void clearError() {
    _errorMessage = null;
    _showPasswordError = false;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _showPasswordErrorMessage() {
    _showPasswordError = true;
    notifyListeners();
  }

  Future<void> signIn() async {
    if (!isFormValid) {
      setErrorMessage('Please fill in all required fields');
      return;
    }

    _setLoading(true);
    clearError();

    try {
      // Sign in user with email and password
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (kDebugMode) {
        print('User signed in successfully: ${userCredential.user?.uid}');
        print('User email: ${userCredential.user?.email}');
        print('Display name: ${userCredential.user?.displayName}');
      }

      _setLoading(false);

      // Navigate to home screen or dashboard
      if (_context != null && _context!.mounted) {
        Navigator.pushReplacementNamed(_context!, '/home');
      }

    } catch (e) {
      _setLoading(false);

      // Handle different types of errors
      if (kIsWeb) {
        _handleWebSignInError(e);
      } else {
        if (e is FirebaseAuthException) {
          _handleFirebaseAuthError(e);
        } else {
          setErrorMessage('An unexpected error occurred. Please try again.');
        }
      }

      if (kDebugMode) {
        print('SignIn error: $e');
      }
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        setErrorMessage('No user found with this email address. Please sign up first.');
        break;
      case 'wrong-password':
        _showPasswordErrorMessage();
        setErrorMessage('Incorrect password. Please try again.');
        break;
      case 'invalid-email':
        setErrorMessage('The email address is not valid.');
        break;
      case 'user-disabled':
        setErrorMessage('This account has been disabled. Contact support.');
        break;
      case 'too-many-requests':
        setErrorMessage('Too many failed attempts. Please try again later.');
        break;
      case 'network-request-failed':
        setErrorMessage('Network error. Please check your connection.');
        break;
      case 'invalid-credential':
        setErrorMessage('Invalid email or password. Please check your credentials.');
        break;
      default:
        setErrorMessage(e.message ?? 'An error occurred during sign in.');
    }
  }

  void _handleWebSignInError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('user-not-found')) {
      setErrorMessage('No user found with this email address. Please sign up first.');
    } else if (errorString.contains('wrong-password')) {
      _showPasswordErrorMessage();
      setErrorMessage('Incorrect password. Please try again.');
    } else if (errorString.contains('invalid-email')) {
      setErrorMessage('The email address is not valid.');
    } else if (errorString.contains('user-disabled')) {
      setErrorMessage('This account has been disabled. Contact support.');
    } else if (errorString.contains('too-many-requests')) {
      setErrorMessage('Too many failed attempts. Please try again later.');
    } else if (errorString.contains('network')) {
      setErrorMessage('Network error. Please check your connection.');
    } else if (errorString.contains('invalid-credential')) {
      setErrorMessage('Invalid email or password. Please check your credentials.');
    } else {
      setErrorMessage('Sign in failed. Please try again.');
    }
  }

  // Method to reset password
  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      setErrorMessage('Please enter your email address to reset password.');
      return;
    }

    _setLoading(true);
    clearError();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      _setLoading(false);

      if (_context != null && _context!.mounted) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
            content: Text('Password reset email sent to ${emailController.text.trim()}'),
            backgroundColor: Colors.green,
          ),
        );
      }

    } catch (e) {
      _setLoading(false);

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            setErrorMessage('No user found with this email address.');
            break;
          case 'invalid-email':
            setErrorMessage('The email address is not valid.');
            break;
          default:
            setErrorMessage('Failed to send reset email. Please try again.');
        }
      } else {
        setErrorMessage('Failed to send reset email. Please try again.');
      }

      if (kDebugMode) {
        print('Reset password error: $e');
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}