import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_komik/data/model/favorite_model.dart';
import 'package:intl/intl.dart';

class FavoritesRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<FavoriteModel>> getFavorites(String userId) async {
    try {
      final favorites = await firestore
          .collection("favorites_$userId")
          .orderBy("created_at")
          .get();
      if (favorites.docs.isNotEmpty) {
        debugPrint("Data favorites: ${favorites.docs.length}");
        return favorites.docs
            .map((e) => FavoriteModel.fromJson(e.data()))
            .toList();
      } else {
        debugPrint("gagal get favorites");
        throw Exception("gagal get favorites");
      }
    } catch (e) {
      debugPrint("error:$e");
      throw Exception("error:$e");
    }
  }

  Future<void> addFavorites(
    String userId,
    int malId,
    String title,
    String images,
    String type,
    String publishedWhen,
  ) async {
    try {
      final favoritesDoc = firestore.collection("favorites_$userId");
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('EEEE - dd-MM-yyyy HH:mm').format(now);
      favoritesDoc.add({
        "userId": userId,
        "mal_id": malId,
        "title": title,
        "images": images,
        "type": type,
        "published_when": publishedWhen,
        "favorite_date": formattedDate,
        "created_at": FieldValue.serverTimestamp(),
      });
      debugPrint("Berhasil tambah favorites");
    } catch (e) {
      debugPrint("Error:$e");
    }
  }

  Future<void> deleteFavorites(String userId, int malId) async {
    QuerySnapshot favoritesSnapshot = await firestore
        .collection("favorites_$userId")
        .where("mal_id", isEqualTo: malId)
        .where("userId", isEqualTo: userId)
        .get();

    // Menghapus setiap dokumen yang ditemukan
    for (QueryDocumentSnapshot doc in favoritesSnapshot.docs) {
      debugPrint("Menghapus dokumen dengan ID: ${doc.id}");
      await doc.reference.delete();
    }
    debugPrint("Berhasil menghapus favorites");
  }
}
