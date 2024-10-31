import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_komik/data/model/user_model.dart';

class UserRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<UserModel> getDataUser(String uid) async {
    try {
      final user = await firestore.collection("users").doc(uid).get();
      if (user.exists) {
        debugPrint("result data user:${user.data()}");
        return UserModel.fromJson(user.data()!);
      } else {
        debugPrint("Gagal mendapatkan data user");
        throw Exception("Gagal mendapatkan data user");
      }
    } catch (e) {
      debugPrint("Error:$e");
      throw Exception("Error:$e");
    }
  }
}
