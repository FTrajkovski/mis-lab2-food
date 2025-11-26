import 'package:flutter/material.dart';
import 'package:mis_lab2_201087/widgets/meal_card.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../services/api_meals_service.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final MealsService _service = MealsService();
  late List<Meal> _meals;
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  late Category _category;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Category) {
      _category = args;
      _loadMeals();
    } else {
      throw Exception("Category argument is required for MealsScreen");
    }
  }

  Future<void> _loadMeals() async {
    final meals = await _service.getMealsByCategory(_category.name);
    setState(() {
      _meals = meals;
      _filteredMeals = meals;
      _isLoading = false;
    });
  }

  void _filterMeals(String query) async {
    if (query.isEmpty) {
      setState(() => _filteredMeals = _meals);
      return;
    }

    final result = await _service.searchMeals(query);

    final filteredByCategory = result
      .where((m) => _meals.any((meal) => meal.id == m.id))
      .toList();

    setState(() {
      _filteredMeals = filteredByCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_category.name)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search meals...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _filterMeals,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: _filteredMeals.length,
                    itemBuilder: (context, index) {
                      final meal = _filteredMeals[index];
                      return MealCard(meal: meal);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
