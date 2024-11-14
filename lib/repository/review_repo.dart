import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_komik/data/model/review_model.dart';
import 'package:intl/intl.dart';

class ReviewRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addReview(String title, String userId, String username,
      String profilePicture, String review, int star) async {
    try {
      final reviewDoc = firestore.collection("reviews_$title");
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
      reviewDoc.add({
        "user_id": userId,
        "username": username,
        "profile_picture": profilePicture,
        "review": review,
        "star": star,
        "created_at": formattedDate,
        "timestamp": FieldValue.serverTimestamp(),
      });
      debugPrint("berhasil menambahkan review untuk komik $title");
    } catch (e) {
      debugPrint("Error:$e");
    }
  }

  Future<List<ReviewModel>> getReview(String title) async {
    try {
      final reviews = await firestore
          .collection("reviews_$title")
          .orderBy("timestamp")
          .get();
      if (reviews.docs.isNotEmpty) {
        debugPrint(
            "Data reviews: ${reviews.docs.map((doc) => doc.data()).toList()}");
        return reviews.docs.map((e) => ReviewModel.fromJson(e.data())).toList();
      } else {
        debugPrint("reviews untuk komik $title kosong");
        return [];
      }
    } catch (e) {
      debugPrint("Error:$e");
      throw Exception("Error:$e");
    }
  }
}
