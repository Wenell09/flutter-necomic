import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  Future<String> login() async {
    try {
      await googleSignIn.signOut();
      googleSignInAccount = await googleSignIn.signIn();
      bool isSuccess = await googleSignIn.isSignedIn();
      if (isSuccess) {
        final googleAuth = await googleSignInAccount!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        // Sign in and get the user credential
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        User? userDetail = userCredential.user;

        if (userDetail != null) {
          await saveUserToFirestore(userDetail);
          return userDetail.uid;
        } else {
          debugPrint("Gagal mendapatkan data pengguna");
          throw Exception("Gagal mendapatkan data pengguna");
        }
      } else {
        debugPrint("Gagal login");
        throw Exception("Gagal login");
      }
    } catch (e) {
      debugPrint("Error:$e");
      throw Exception("Error:$e");
    }
  }

  // Fungsi untuk menyimpan data pengguna ke Firestore
  Future<void> saveUserToFirestore(User user) async {
    final userDoc = firestore.collection('users').doc(user.uid);

    // Mengecek apakah data pengguna sudah ada di Firestore
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        'username': user.displayName ?? '',
        'photo': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'lastSignIn': user.metadata.lastSignInTime,
      });
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
