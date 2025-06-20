import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get current user model
  Future<UserModel?> getCurrentUserModel() async {
    final user = currentUser;
    if (user == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user model: $e');
      return null;
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(
    User user, {
    bool isAnonymous = false,
  }) async {
    try {
      final userDoc = _firestore.collection('users').doc(user.uid);
      final docSnapshot = await userDoc.get();

      if (!docSnapshot.exists) {
        final now = DateTime.now();
        final userModel = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName,
          photoURL: user.photoURL,
          isAnonymous: isAnonymous,
          subscription: const UserSubscription.free(),
          freeTrialStartDate: now,
          freeTrialEndDate: now.add(const Duration(days: 5)), // 5 free days
          createdAt: now,
          lastLoginAt: now,
        );

        await userDoc.set(userModel.toJson());
      } else {
        // Update last login
        await userDoc.update({'lastLoginAt': FieldValue.serverTimestamp()});
      }
    } catch (e) {
      debugPrint('Error creating user document: $e');
    }
  }

  // Sign in anonymously (skip login)
  Future<UserCredential?> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      if (credential.user != null) {
        await _createUserDocument(credential.user!, isAnonymous: true);
      }
      return credential;
    } catch (e) {
      debugPrint('Error signing in anonymously: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await _createUserDocument(credential.user!);
      }
      return credential;
    } catch (e) {
      debugPrint('Error signing in with email: $e');
      return null;
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await _createUserDocument(credential.user!);
      }
      return credential;
    } catch (e) {
      debugPrint('Error registering with email: $e');
      return null;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!);
      }
      return userCredential;
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      return null;
    }
  }

  // Sign in with Apple
  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!);
      }
      return userCredential;
    } catch (e) {
      debugPrint('Error signing in with Apple: $e');
      return null;
    }
  }

  // Convert anonymous account to permanent
  Future<UserCredential?> linkAnonymousWithGoogle() async {
    try {
      final user = currentUser;
      if (user == null || !user.isAnonymous) return null;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await user.linkWithCredential(credential);
      if (userCredential.user != null) {
        // Update user document to mark as non-anonymous
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .update({
              'isAnonymous': false,
              'email': userCredential.user!.email,
              'displayName': userCredential.user!.displayName,
              'photoURL': userCredential.user!.photoURL,
            });
      }
      return userCredential;
    } catch (e) {
      debugPrint('Error linking anonymous account with Google: $e');
      return null;
    }
  }

  // Update user subscription
  Future<void> updateUserSubscription(UserSubscription subscription) async {
    try {
      final user = currentUser;
      if (user == null) return;

      await _firestore.collection('users').doc(user.uid).update({
        'subscription': subscription.toJson(),
        'subscriptionStartDate': subscription.when(
          free: () => null,
          weekly: (start, _, __) => Timestamp.fromDate(start),
          monthly: (start, _, __) => Timestamp.fromDate(start),
          yearly: (start, _, __) => Timestamp.fromDate(start),
        ),
        'subscriptionEndDate': subscription.when(
          free: () => null,
          weekly: (_, end, __) => Timestamp.fromDate(end),
          monthly: (_, end, __) => Timestamp.fromDate(end),
          yearly: (_, end, __) => Timestamp.fromDate(end),
        ),
      });
    } catch (e) {
      debugPrint('Error updating user subscription: $e');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Error sending password reset email: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      final user = currentUser;
      if (user == null) return;

      // Delete user document from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete user account
      await user.delete();
    } catch (e) {
      debugPrint('Error deleting account: $e');
      rethrow;
    }
  }

  // Check if user can connect to device
  Future<bool> canConnectToDevice() async {
    final userModel = await getCurrentUserModel();
    return userModel?.canConnectToDevice ?? false;
  }

  // Check if user has active subscription
  Future<bool> hasActiveSubscription() async {
    final userModel = await getCurrentUserModel();
    return userModel?.hasActiveSubscription ?? false;
  }

  // Get subscription status
  Future<String> getSubscriptionStatus() async {
    final userModel = await getCurrentUserModel();
    return userModel?.subscriptionStatus ?? 'Free';
  }
}
