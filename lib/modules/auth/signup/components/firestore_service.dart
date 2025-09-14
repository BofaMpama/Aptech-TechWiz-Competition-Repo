import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawfect/modules/auth/signup/components/user_model.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserProfile({
    required String userId,
    required String email,
    required String fullName,
    required UserRole role,
  }) async {
    await _db.collection('users').doc(userId).set({
      'email': email,
      'fullName': fullName,
      'role': role.name,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}