import 'package:flutter/material.dart';
import '../services/favorites_manager.dart';
import '../widgets/meal_card.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Meal> _favorites;
  late List<Meal> _filteredFavorites;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favorites = FavoritesManager.favorites;
    _filteredFavorites = List.from(_favorites);
  }

  void _filterFavorites(String query) {
    if (query.isEmpty) {
      setState(() => _filteredFavorites = List.from(_favorites));
      return;
    }

    final filtered = _favorites
        .where((meal) =>
            meal.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() => _filteredFavorites = filtered);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Recipes")),
      body: _favorites.isEmpty
          ? const Center(child: Text("No favorite recipes yet"))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search favorites...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _filterFavorites,
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
                    itemCount: _filteredFavorites.length,
                    itemBuilder: (ctx, i) {
                      final meal = _filteredFavorites[i];
                      return MealCard(meal: meal);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}