import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal_details.dart';

class MealDetailsService {
  Future<MealDetails> getMealDetails(String id) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mealJson = data['meals'][0];
      return MealDetails.fromJson(mealJson);
    } else {
      throw Exception('Failed to load meal details');
    }
  }
  Future<MealDetails> getRandomMeal() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mealJson = data['meals'][0];
      return MealDetails.fromJson(mealJson);
    } else {
      throw Exception('Failed to load random meal');
    }
  }
}
