import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoriesService {
  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> categoriesJson = data["categories"];

      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }
}