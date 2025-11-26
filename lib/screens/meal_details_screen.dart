import 'package:flutter/material.dart';
import '../models/meal_details.dart';
import '../services/api_meal_details_service.dart';
import '../widgets/meal_details_card.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final MealDetailsService _service = MealDetailsService();
  MealDetails? _meal;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    _loadMealDetails(mealId);
  }

  Future<void> _loadMealDetails(String id) async {
    final meal = await _service.getMealDetails(id);
    setState(() {
      _meal = meal;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_meal?.name ?? "Meal Details")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : MealDetailsCard(meal: _meal!),
    );
  }
}
