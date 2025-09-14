import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/user_model.dart';

class SignupViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Navigation context
  BuildContext? _context;

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  UserRole? _selectedRole;
  bool _acceptedTerms = false;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserRole? get selectedRole => _selectedRole;
  bool get acceptedTerms => _acceptedTerms;

  // Form validation getter
  bool get isFormValid {
    return fullNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        _selectedRole != null &&
        passwordController.text == confirmPasswordController.text;
  }

  // Methods
  void setContext(BuildContext context) {
    _context = context;
  }

  void setSelectedRole(UserRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  void setAcceptedTerms(bool accepted) {
    _acceptedTerms = accepted;
    clearError(); // Clear error when user accepts terms
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
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

  void _navigateToRoleProfile() {
    if (_context == null) {
      if (kDebugMode) {
        print('Navigation failed: Context is null');
      }
      return;
    }

    if (_selectedRole == null) {
      if (kDebugMode) {
        print('Navigation failed: No role selected');
      }
      return;
    }

    String route;
    switch (_selectedRole!) {
      case UserRole.petOwner:
        route = '/pet-owner-profile';
        break;
      case UserRole.veterinarian:
        route = '/veterinarian-profile';
        break;
      case UserRole.petSitter:
        route = '/pet-sitter-profile'; // You can create this later
        break;
      case UserRole.petShop:
        route = '/shelter-admin-profile';
        break;
    }

    if (kDebugMode) {
      print('Navigating to: $route for role: ${_selectedRole!.displayName}');
    }

    try {
      Navigator.pushReplacementNamed(_context!, route);
    } catch (e) {
      if (kDebugMode) {
        print('Navigation error: $e');
      }
      setErrorMessage('Navigation failed. Please check your routes configuration.');
    }
  }

  Future<void> signUp() async {
    if (!_acceptedTerms) {
      setErrorMessage('Please accept the terms and conditions');
      return;
    }

    if (!isFormValid) {
      setErrorMessage('Please fill in all required fields correctly');
      return;
    }

    _setLoading(true);
    clearError();

    try {
      // Create user with email and password
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Update the user's display name
      await userCredential.user?.updateDisplayName(fullNameController.text.trim());

      // You can add additional user data to Firestore here if needed
      // await _saveUserDataToFirestore(userCredential.user);

      // Success - navigate to role-specific profile screen
      if (kDebugMode) {
        print('User created successfully: ${userCredential.user?.uid}');
      }

      _setLoading(false);

      // Navigate based on selected role
      _navigateToRoleProfile();

    } catch (e) {
      _setLoading(false);

      // Handle different types of errors
      if (kIsWeb) {
        setErrorMessage(_parseWebError(e));
      } else {
        if (e is FirebaseAuthException) {
          setErrorMessage(_parseFirebaseError(e));
        } else {
          setErrorMessage('An unexpected error occurred. Please try again.');
        }
      }

      if (kDebugMode) {
        print('Signup error: $e');
      }
    }
  }

  String _parseFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return e.message ?? 'An error occurred during signup.';
    }
  }

  String _parseWebError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('email-already-in-use')) {
      return 'An account already exists for this email address';
    } else if (errorString.contains('weak-password')) {
      return 'The password provided is too weak';
    } else if (errorString.contains('invalid-email')) {
      return 'Invalid email address';
    } else if (errorString.contains('network')) {
      return 'Network error. Please check your connection';
    } else {
      return 'Signup failed. Please try again.';
    }
  }

  // Optional: Save additional user data to Firestore
  // Future<void> _saveUserDataToFirestore(User? user) async {
  //   if (user == null) return;
  //
  //   await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
  //     'fullName': fullNameController.text.trim(),
  //     'email': emailController.text.trim(),
  //     'role': _selectedRole?.name,
  //     'createdAt': FieldValue.serverTimestamp(),
  //   });
  // }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}