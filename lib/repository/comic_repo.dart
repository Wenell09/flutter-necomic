import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_komik/data/constant/base_url.dart';
import 'package:flutter_komik/data/model/character_model.dart';
import 'package:flutter_komik/data/model/comic_data.dart';
import 'package:flutter_komik/data/model/comic_model.dart';
import 'package:flutter_komik/data/model/recom_model.dart';
import 'package:http/http.dart' as http;

class ComicRepo {
  Future<ComicData> getTopComic(String query, String filter, int page) async {
    try {
      final response = await http.get(Uri.parse(
          "$baseUrl/top/manga?type=$query&filter=$filter&page=$page"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        debugPrint("komik $query berhasil didapat");
        return ComicData.fromJson(result);
      } else {
        throw Exception("gagal get top komik $query");
      }
    } catch (e) {
      throw Exception("error:$e");
    }
  }

  Future<ComicModel> getDetailComic(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/manga/$id"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body)["data"];
        debugPrint("Detail komik dengan id:$id berhasil didapat");
        return ComicModel.fromJson(result);
      } else {
        throw Exception("Gagal get detail komik id:$id");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }

  Future<List<CharacterModel>> getCharacters(int id) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/manga/$id/characters"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        debugPrint("chara untuk id:$id berhasil didapat");
        return result.map((e) => CharacterModel.fromJson(e)).toList();
      } else {
        throw Exception("gagal get chara");
      }
    } catch (e) {
      throw Exception("error:$e");
    }
  }

  Future<List<RecomModel>> getRecommendations(int id) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/manga/$id/recommendations"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        debugPrint("Recom untuk $id berhasil didapat");
        return result.map((e) => RecomModel.fromJson(e)).toList();
      } else {
        throw Exception("Gagal get recom");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }
}
