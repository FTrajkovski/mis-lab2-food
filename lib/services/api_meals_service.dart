import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealsService {
  Future<List<Meal>> getMealsByCategory(String category) async {
    final url =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final meals = (json["meals"] as List)
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList();
      return meals;
    } else {
      throw Exception("Failed to load meals");
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final url = "https://www.themealdb.com/api/json/v1/1/search.php?s=$query";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json["meals"] == null) return [];

      return (json["meals"] as List)
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList();
    }
    return [];
  }

  Future<Meal> getMealDetails(String id) async {
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id"),
    );
    final data = jsonDecode(response.body);
    final mealJson = data['meals'][0];
    return Meal.fromJson(mealJson);
  }
}
