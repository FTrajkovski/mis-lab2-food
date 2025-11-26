import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_categories_service.dart';
import '../services/api_meal_details_service.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.title});

  final String title;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesService _service = CategoriesService();
  final MealDetailsService _mealDetailsService = MealDetailsService();
  late List<Category> _categories;
  bool _isLoading = true;
  bool _isRandomLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await _service.getCategories();
    setState(() {
      _categories = categories;
      _isLoading = false;
      _isRandomLoading = false;
    });
  }

  Future<void> _showRandomMeal() async {
    setState(() => _isRandomLoading = true);
    final randomMeal = await _mealDetailsService.getRandomMeal();
    Navigator.pushNamed(context, "/meal_details", arguments: randomMeal.id);
    setState(() => _isRandomLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton.icon(
                    icon: _isRandomLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.shuffle),
                    label: const Text("Random Recipe"),
                    onPressed: _isRandomLoading ? null : _showRandomMeal,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(category: _categories[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
