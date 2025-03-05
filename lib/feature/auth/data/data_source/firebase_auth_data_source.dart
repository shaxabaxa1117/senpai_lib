// features/auth/data/data_sources/firebase_auth_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senpai_lib/feature/auth/data/model/user_model.dart';



class FirebaseAuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseAuthDataSource(this.auth, this.firestore);

  Future<UserModel> signUp(String email, String password, String nickname) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = credential.user!.uid;
      final user = UserModel(id: userId, nickname: nickname);
      await firestore.collection('users').doc(userId).set(user.toJson());
      return user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = credential.user!.uid;
      final userDoc = await firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) throw Exception('User data not found');
      return UserModel.fromJson(userDoc.data()!);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) return null;
    final userDoc = await firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) return null;
    return UserModel.fromJson(userDoc.data()!);
  }
}