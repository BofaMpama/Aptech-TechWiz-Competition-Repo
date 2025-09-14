import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawfect/modules/auth/signup/components/user_model.dart';

import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = result.user;
    if (user != null) {
      await _firestoreService.createUserProfile(
        userId: user.uid,
        email: email,
        fullName: fullName,
        role: role,
      );
      await user.updateDisplayName(fullName);
    }

    return user;
  }
}